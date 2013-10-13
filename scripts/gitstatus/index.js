#!/usr/bin/env node
var program = require('commander');

var fs = require('fs');
var _ = require('lodash');
var wrench = require('wrench');
var async = require('async');
var child_process = require('child_process');

program
  .version('0.0.1')

program
  .command('changed [projectfolder] [match]')
  .description('scan for git status in all projects')
  .action(function(projectfolder, match){

    projectfolder = projectfolder.replace(/\/$/, '');

    fs.readdir(projectfolder, function(error, names){

      names = names.filter(function(name){
        if(!match){
          return true;
        }
        return name.indexOf(match)>=0;
      })
      
      async.forEachSeries(names, function(name, nextname){

        fs.exists(projectfolder + '/' + name + '/.git', function(exists){
          if(!exists){
            nextname();
            return;
          }

          child_process.exec('git status', {
            cwd:projectfolder + '/' + name
          }, function(error, stdout, stderr){
            if(stdout.match(/working directory clean/)){
              nextname();
              return;
            }
            console.log('-------------------------------------------');
            console.log(projectfolder + '/' + name);
            console.log(error);
            console.log(stdout);
            console.log(stderr);
            nextname();
          })
        })

        
      }, function(error){
        console.log('done');  
      })
    })
    
  })

program
  .command('*')
  .action(function(command){
    console.log('command: "%s" not found', command);
  })

program.parse(process.argv);