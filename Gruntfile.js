module.exports = function(grunt) {
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

    lifecycle: {
      compile: ['coffee'],
      package: ['uglify']
    },

    clean: ['build', 'cs/*.js', 'cs/*.js.map', 'js/diaspora_connect.js'],

    uglify: {
      options: {
        banner: '/*! <%= pkg.name %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'
      },
      build: {
        src: 'js/*.js',
        dest: 'build/<%= pkg.name %>.min.js'
      }
    },

    coffee: {
      glob_to_multiple: {
        expand: true,
        flatten: true,
        cwd: 'cs/',
        src: ['*.coffee'],
        dest: 'js/',
        ext: '.js'
      }
    }
  });

  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-build-lifecycle');
  grunt.registerTask('default', ['package']);

};