
##根据寄存器信息，生成basic sequence
import pprint

import sequence_gen.read_register as reg
import shutil,os, sys
import json
from mako.lookup import TemplateLookup

# create sequence directory
seqs_dir = reg.sheetnames[0] + '_sequences'
if os.path.exists(seqs_dir):
    shutil.rmtree(seqs_dir)
os.mkdir(seqs_dir)
print('RESULT DIR: ' + seqs_dir)
print('')

# Open a new text file and write the contents of reg data to it.
print('Write basic sequence......')
seq = open(seqs_dir + os.sep + reg.sheetnames[0]+'_basic_seq.svh', 'w')

seq.write('`ifdef ' + reg.sheetnames[0].upper() + '_BASIC_SEQ_SVH\n')
seq.write('`define ' + reg.sheetnames[0].upper() + '_BASIC_SEQ_SVH\n')
seq.write('\n')
seq.write('class ' + reg.sheetnames[0] + '_basic_seq extends uvm_sequence;\n')
seq.write('  `uvm_object_utils(' + reg.sheetnames[0] + '_basic_seq)\n')
seq.write('\n')

##定义各个寄存器的名字
seq.write('  //' + reg.sheetnames[0] + ' reg name\n')
for key in reg.regbitdata.keys():
    seq.write('  bit [31:0] ' + key + ';\n')

seq.write('\n')

##定义每个寄存器的bit位：
for reg_name in reg.regbitdata.keys():
    seq.write('  //' + reg_name + ' bits:\n')
    for k,v in reg.regbitdata[reg_name].items():
        if(str(v['bit_width']) == '1'):
            seq.write('  bit ' + k + ';\n')
        else:
            seq.write('  bit [' + str(v['bit_width']-1) + ':0] ' + k + ';\n')
    seq.write('\n')

#pprint.pprint(list(reg.regbitdata.items()))
#print(list(reg.regbitdata[reg_name].items()))

##定义basic_seq中的function
seq.write('  function new(string name = "' +reg.sheetnames[0] + '_basic_seq");\n')
seq.write('    super.new(name);\n')
seq.write('  endfunction:new\n')
seq.write('\n')

##定义task
seq.write('  task body();\n')
for reg_name in reg.regbitdata.keys():
    reg_bits = list(reg.regbitdata[reg_name].items())
    reg_bits.reverse()
    print(reg_name)
    print(reg_bits)
    j = 31 #寄存器总的位宽数
    i = 0
    print(j)
    seq.write('    ' + reg_name + ' = ' + '{')
    while(i < len(reg_bits)):

        if(str(reg_bits[i][1]['bit_width']) == '1'):
            if (str(reg_bits[i][1]['bit_site']) == str(j)):
                seq.write(str(reg_bits[i][0]))
                if (str(reg_bits[i][1]['bit_site']) != '0'):
                    seq.write(',')
                j = j - 1
                i = i + 1
            else:
                seq.write('1\'b0,')
                j = j -1
        else:
            if (str(reg_bits[i][1]['bit_site']+reg_bits[i][1]['bit_width']-1) == str(j)):
                seq.write(str(reg_bits[i][0]))
                if (str(reg_bits[i][1]['bit_site']) != '0'):
                    seq.write(',')
                j = j - reg_bits[i][1]['bit_width']
                i = i + 1
            else:
                seq.write('1\'b0,')
                j = j - 1

    if(str(reg_bits[i-1][1]['bit_site']) != '0'):
        seq.write(str(reg_bits[i-1][1]['bit_site']) + '\'h0;')

    seq.write('};\n')

seq.write('  endtask:body\n')
seq.write('\n')

seq.write('\n')
seq.write('endclass:' + reg.sheetnames[0] + '_basic_seq\n')
seq.write('`endif //' + reg.sheetnames[0].upper() + '_BASIC_SEQ_SVH\n')
seq.close();

#############################
if len(sys.argv) == 2:
    conf_file = sys.argv[1]
else:
    conf_file = "../env_gen/env_config.jscon"

print('uvm sequences generator 1.0')
print('')

# set template path
template_path = os.getcwd() + os.sep + 'template_sequences'
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
seqs_dir = env_name + '_sequences'
if os.path.exists(seqs_dir):
    shutil.rmtree(seqs_dir)
os.mkdir(seqs_dir)
print('RESULT DIR: ' + seqs_dir)
print('')

# define template handle function
def uvm_file_gen(filename, **kwargs):
    uvm_template = mylookup.get_template(filename)
    fd = open(seqs_dir + os.sep + filename.replace('template', env_name), 'w',newline='')
    fd.write(uvm_template.render(**kwargs))
    fd.close()
    print('Generating ' + seqs_dir + os.sep + filename.replace('template', env_name))

# template rendering
uvm_file_gen('template_seqs_pkg.sv', env_name=env_name, basic_test_name=basic_test_name, vsqr_name=vsqr_name, interface=interface,
             agent=agent, reg_model_name=reg_model_name, scoreboard=scoreboard, coverage=coverage, seq_item=seq_item)