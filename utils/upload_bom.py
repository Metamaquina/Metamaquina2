#!/usr/bin/python
# -*- coding: utf-8 -*-

"""
// (c) 2013 Metamáquina <http://www.metamaquina.com.br/>
//
// Author:
// * Rodrigo Rodrigues da Silva <rsilva@metamaquina.com.br>
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
"""

import sys
import xmlrpclib
import re
import argparse


def search_product_by_code(code):
    args = [('default_code', '=', code)]
    ids = sock.execute(dbname, uid, pwd, 'product.product', 'search', args)
    #print ids
    #print len(ids)
    if len(ids) == 0:
        #print "Product reference not found!"
        raise Exception('[ERROR] Product reference [%(default_code)s] not found!' % item)
    else:
        fields = ['id', 'default_code', 'name_template']
        results = sock.execute(dbname, uid, pwd, 'product.product', 'read', ids, fields)
        #print results
        if len(results) > 1:
            #print 'Duplicated entry. Reference: %s' % item['default_code']
            raise Exception('[ERROR] Product reference [%(default_code)s] not unique!' % item)
        else:
            return (results[0]['id'], results[0]['name_template'])

def create_master_bom(product_id, name):
    args = [('name', '=', name)]
    ids = sock.execute(dbname, uid, pwd, 'mrp.bom', 'search', args)
    if not len(ids) == 0:
        raise Exception('[ERROR] BOM with name %s already exists.' % name)

    master_bom = {}
    master_bom['product_id'] = product_id
    master_bom['name'] = name
    master_bom['product_uom'] = 1
    return sock.execute(dbname, uid, pwd, 'mrp.bom', 'create', master_bom)

def create_bom_line(item):
    item['product_uom'] = 1
    return sock.execute(dbname, uid, pwd, 'mrp.bom', 'create', item)

    
# TODO: put defaults in .rc file
D_USERNAME = 'admin'
D_DBNAME = 'mm_test'
D_PWD = 'test'
D_URL = "erp.metamaquina.com.br"

## Parse CLI arguments ##
parser = argparse.ArgumentParser(description='Process BOM from standard input and load items to OpenERP.')

parser.add_argument('-d', metavar='DATABASE', default=D_DBNAME, dest='dbname',
                    help='Database name')
parser.add_argument('-u', metavar='USERNAME', default=D_USERNAME, dest='username',
                    help='Database user')
parser.add_argument('-p', metavar='PASSWORD', default=D_PWD, dest='pwd',
                    help='Database password')
parser.add_argument('-s', metavar='URL', default=D_URL, dest='server_url',
                    help='Server URL')

group = parser.add_mutually_exclusive_group()
group.add_argument('--quiet', action='store_true', default=False,
                    help='Don\'t show warnings')
group.add_argument('--verbose', action='store_true', default=False,
                    help='Show debugging info')
                    
parser.add_argument('--pedantic', action='store_true', default=False,
                    help='Halt on all errors')
parser.add_argument('--dry-run', action='store_true', default=False,
                    help='Just parse and check BOM, don\'t load to ERP')
# positional
parser.add_argument('bom_name', metavar='BOM_NAME', type=str,
                    help='BOM name (no whitespaces)')
parser.add_argument('master_product_code', metavar='PRODUCT_CODE', type=str,
                    help='Master product code (no whitespaces)')
parser.add_argument('infile', metavar='INFILE', nargs='?', type=argparse.FileType('r'), default=sys.stdin,
                    help='Input file (MM OpenSCAD BOM format)')

args = parser.parse_args(sys.argv[1:len(sys.argv)])
#print args

username = args.username
dbname = args.dbname
pwd = args.pwd
master_product_code = args.master_product_code
bom_name = args.bom_name
verbose = args.verbose
pedantic = args.pedantic
quiet = args.quiet
server_url = args.server_url
dry_run = args.dry_run
infile = args.infile

if quiet: verbose = False

### BEGIN SCRIPT ###

# Get the object socket
sock_common = xmlrpclib.ServerProxy ('https://%s/xmlrpc/common' % server_url)
uid = sock_common.login(dbname, username, pwd)
if not uid:
    print 'Unable to connect to database %s at %s' % (dbname, server_url)
    exit (-1)
sock = xmlrpclib.ServerProxy('https://%s/xmlrpc/object' % server_url)

pattern = re.compile('\s*(\d+)\s*\[([^\]]*)\]\s*(.*)')
# group 0: quantity
# group 1: [part ref]
# group 2: part name

parser_skipped = 0
erp_skipped = 0
bom_items = []

# TODO: ignore lines that don't start with a number
for line in infile:
    # match pattern
    ma = pattern.match(line)
    if not ma :
        if not quiet:
            sys.stdout.write('[WARN] Invalid line: %s' % line)
        parser_skipped+=1
    else:
        item = {}
        item['product_qty'] = int(ma.group(1))
        item['default_code'] = ma.group(2)
        try:
            (item['product_id'], item['name_template']) = search_product_by_code(item['default_code'])
        except Exception, e:
            print e #TODO: write to stdout
            erp_skipped += 1
            continue
        bom_items.append(item)
        if verbose:
            print '[DEBUG] Item added %s' % item

if pedantic and (erp_skipped):
    print "[FATAL] I found that %d items are either duplicated or don't exist. Fix your OpenERP database to match the BOM and try again. Run without --pedantic if you know what you're doing." % erp_skipped
    exit (-1)

if verbose:
    print ''
    print '===CHECKLIST==='
    print 'BOM_NAME: %s PRODUCT_CODE: %s\n' % (bom_name, master_product_code)
    for item in bom_items:
        print '%(product_qty)5d \t [%(default_code)s] %(name_template)s' % item
    print ""

#if interactive:
#if not raw_input("%s (y/N) " % "Upload this BOM?").lower() == 'y':
#    sys.exit(-1)

if not dry_run:
    # create BOM
    (master_product_id, foo) = search_product_by_code(master_product_code)
    try:
        master_bom_id = create_master_bom(master_product_id, bom_name)
    except Exception, e:
        print e #TODO: write to stdout
        exit (-1)
    if not quiet: print 'BOM %s created' % bom_name
    # create BOM lines
    for bom_line in bom_items:
        bom_line['bom_id'] = master_bom_id
        bom_line_id = create_bom_line(bom_line)

if not quiet:
    print "Total invalid input lines: %s" % (parser_skipped-2) #-2 header & footer
    print "Total items not found or duplicated on ERP: %s" % erp_skipped
    print "BOM lines created: %s" % len(bom_items)
if dry_run:
    print "Option --dry-run was provided, therefore no items have been created on database %s" % dbname
