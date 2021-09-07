### sim_gen_1.0

#!/usr/bin/env python

import os
import sys
import shutil
import json
from mako.template import Template
from mako.lookup import TemplateLookup

if len(sys.argv) == 2:
    conf_file = sys.argv[1]
else:
    conf_file = "../env_gen/env_config.jscon"

print('uvm simulation generator 1.0')
print('')

# set template path
template_path = os.getcwd() + os.sep + 'template_sim'
mylookup = TemplateLookup(directories=[template_path], module_directory='/tmp/mako_modules')
print('TEMPLATE DIR: ' + template_path)
print('')

# get agent parameters from config.json
#f = open(conf_file, 'r')
with open(conf_file, 'r') as f:
    load_f = f.read()
    conf = json.loads(load_f)
env_name = conf['env']
basic_test_name = conf['basic_test_name']
vsqr_name = conf['vsqr_name']
interface = conf['interface']
agent = conf['agent']
reg_model_name = conf['reg_model_name']
scoreboard = conf['scoreboard']
coverage = conf['coverage']
seq_item = conf['seq_item']

f.close()
print('Current Configuration:')
print('  env name: ' + env_name)
print('  basic test name: ' + basic_test_name)
print('  vsqr name:' + vsqr_name)
print('  interface:' + str(interface))
print('  agent:' + str(agent))
print('  reg_model_name:' + reg_model_name)
print('  scoreboard:' + scoreboard)
print('  coverage:' + coverage)
print('  seq_item:' + str(seq_item))
print('')

# create agent directory
sim_dir = env_name + '_sim'
if os.path.exists(sim_dir):
    shutil.rmtree(sim_dir)
os.mkdir(sim_dir)
print('RESULT DIR: ' + sim_dir)
print('')

# define template handle function
def uvm_file_gen(filename, **kwargs):
    uvm_template = mylookup.get_template(filename)
    fd = open(sim_dir + os.sep + filename.replace('template', env_name), 'w',newline='')
    fd.write(uvm_template.render(**kwargs))
    fd.close()
    print('Generating ' + sim_dir + os.sep + filename.replace('template', env_name))

# template rendering
uvm_file_gen('flist.f', env_name=env_name, basic_test_name=basic_test_name, vsqr_name=vsqr_name, interface=interface,
             agent=agent, reg_model_name=reg_model_name, scoreboard=scoreboard, coverage=coverage, seq_item=seq_item)

t_makefile = open(r"./template_sim/makefile")
makefile = open(env_name + '_sim' + "/makefile","w")
s = t_makefile.read()
w = makefile.write(str(s))
t_makefile.close()
makefile.close()

