#!/usr/bin/env node
var program = require('commander');

var fs = require('fs');
var _ = require('lodash');
var wrench = require('wrench');
var async = require('async');
var child_process = require('child_process');
var path = require('path');
function run(paths, done){

  async.forEachSeries(paths, function(path, nextname){

    fs.exists(path + '/.git', function(exists){
      if(!exists){
        nextname();
        return;
      }

      child_process.exec('git status', {
        cwd:path
      }, function(error, stdout, stderr){
        if(stdout.match(/working directory clean/)){
          nextname();
          return;
        }
        console.log('-------------------------------------------');
        console.log(path);
        console.log(error);
        console.log(stdout);
        console.log(stderr);
        nextname();
      })
    })

    
  }, done)
}
program
  .option('-f, --file <path>', 'a file to read module names from', '')
  .version('0.0.1')


program
  .command('changed [projectfolder] [match]')
  .description('scan for git status in all projects')
  .action(function(projectfolder, match){

    if(!(projectfolder||'').match(/\w/)){
      console.log('projectfolder needed');
      process.exit();
    }
    
    projectfolder = projectfolder.replace(/\/$/, '');

    if(program.file.match(/\w/)){
      var file = program.file;

      if(file.indexOf('.')==0){
        file = path.normalize(process.cwd() + '/' + file);
      }

      fs.readFile(file, 'utf8', function(error, list){

        var names = list.split(/\n/);



        names = names.filter(function(name){
          if(!match){
            return true;
          }
          return name.indexOf(match)>=0;
        }).map(function(name){
          return projectfolder + '/' + name;
        })

        run(names, function(){

        })
      })
    }
    else{
      fs.readdir(projectfolder, function(error, names){

        names = names.filter(function(name){
          if(!match){
            return true;
          }
          return name.indexOf(match)>=0;
        }).map(function(name){
          return projectfolder + '/' + name;
        })

        run(names, function(){

        })
      })
    }

    

    
  })

program
  .command('*')
  .action(function(command){
    console.log('command: "%s" not found', command);
  })

program.parse(process.argv);