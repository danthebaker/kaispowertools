#!/usr/bin/env node
var program = require('commander');

var fs = require('fs');
var _ = require('lodash');
var wrench = require('wrench');
var child_process = require('child_process');

program
  .version('0.0.1')

program
  .command('component [infolder] [projects]')
  .description('symlink all binocarlos components in a folder')
  .action(function(infolder, projects){

    projects = projects || '/srv/projects';

    infolder = infolder.replace(/\/$/, '');
    infolder = infolder.replace(/\/components$/, '');

    infolder += '/components';

    fs.readdir(infolder, function(error, names){
      
      names.forEach(function(name){
        var componentname = name;
        if(name.match(/^binocarlos-/)){
          var stat = fs.lstatSync(infolder + '/' + name);
          if(stat.isSymbolicLink()){
            
          }
          else{
            componentname = name.replace(/^binocarlos-/, '');
            wrench.rmdirSyncRecursive(infolder + '/' + name, true);
            fs.symlinkSync(projects + '/' + componentname, infolder + '/' + name)
            console.log(infolder + '/' + name + ' -> ' + '/srv/projects/' + componentname);  
          }
          
        }
      })

      console.log('done');
      
    })
    
  })

program
  .command('nodemodule [module] [projects]')
  .description('symlink all modules that are projects in the given folder')
  .action(function(module, projects){

    module = module.replace(/\/$/, '');
    projects = projects.replace(/\/$/, '');

    var modules_dir = module + '/node_modules';

    fs.readdir(modules_dir, function(error, names){
      
      names.forEach(function(name){
        
        var exists = fs.existsSync(projects + '/' + name);

        if(exists){
          var stat = fs.lstatSync(modules_dir + '/' + name);
          if(stat.isSymbolicLink()){
            
          }
          else{
            wrench.rmdirSyncRecursive(modules_dir + '/' + name, true);
            fs.symlinkSync(projects + '/' + name, modules_dir + '/' + name);
            console.log(projects + '/' + name + ' -> ' + modules_dir + '/' + name);
          }
        }
      })

      console.log('done');
      
    })
    
  })

program
  .command('*')
  .action(function(command){
    console.log('command: "%s" not found', command);
  })

program.parse(process.argv);