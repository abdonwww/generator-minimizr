'use strict';
var util = require('util');
var path = require('path');
var yeoman = require('yeoman-generator');


var PandaGenerator = module.exports = function PandaGenerator(args, options, config) {
  yeoman.generators.Base.apply(this, arguments);

  this.on('end', function () {
    this.installDependencies({ skipInstall: options['skip-install'] });
  });

  this.pkg = JSON.parse(this.readFileAsString(path.join(__dirname, '../package.json')));
};

util.inherits(PandaGenerator, yeoman.generators.Base);

PandaGenerator.prototype.askFor = function askFor() {
  var cb = this.async(),
      cwd = process.cwd();

  // have Yeoman greet the user.
  // console.log(this.yeoman);

  var prompts = [{
    type: 'input',
    name: 'projectName',
    message: 'What would you like to name your project?',
    default: cwd.substr(cwd.lastIndexOf('/')+1)
  },
  {
    type: 'input',
    name: 'gitUrl',
    message: 'What is the url of the Git repository if you use?',
    default: ''
  }
  ];

  this.prompt(prompts, function (props) {
    this.projectName = props.projectName;
    this.gitUrl = props.gitUrl;
    // this.preprocessors = props.preprocessors;

    cb();
  }.bind(this));
};

PandaGenerator.prototype.app = function app() {
  this.directory('_src', 'src');

  this.template('_Gruntfile.coffee', 'Gruntfile.coffee');
  this.template('_package.json', 'package.json');
  this.template('_README.md', 'README.md');
};

PandaGenerator.prototype.projectfiles = function projectfiles() {
  this.copy('editorconfig', '.editorconfig');
  this.copy('gitignore', '.gitignore');
};
