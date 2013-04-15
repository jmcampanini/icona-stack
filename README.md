icona-stack
===========
A starter kit for client-side web development. The stack includes:

- `grunt` - workflow automation
- `require.js` - dependency management
- `jQuery` - DOM manipulation
- `lodash` - helpful functionality
- `Backbone` - application structure
- `Handlebars` - JavaScript templating
- `LESS` - CSS language


Setup
-----
1. Modify the following files:
	- `component.json` - Bower Dependencies
	- `Gruntfile.coffee` - Grunt Build Configuration
	- `package.json` - NPM Dependencies

2. Install the NPM Packages.

		npm install

3. Install the Bower Packages.

		bower install

4. Build the project in development mode.

		grunt develop

5. Launch the web browser to: [http://127.0.0.1:8000/](http://127.0.0.1:8000/)

Directory Structure
-------------------
The directory structure is setup in 2 phases: pre-compiled + post-compiled. The directories for these are `src` and `dist`, respectively.
	
	.
	├── component.json                    - Bower Dependencies
	├── Gruntfile.coffee                  - Grunt Configuration
	├── package.json                      - NPM Dependencies
	├── README.md                         - this file
	├── dist                              - Distribution - the built project
	├── docs                              - Documentation
	├── src
	│   ├── index.html                    - HTML files can live here
	│   ├── assets                        - project assets: images, fonts, etc.
	│   │   └── images
	│   ├── coffee                        - CoffeeScript Code
	│   │   ├── build.coffee              - Require.js Configuration
	│   │   └── main.coffee               - Application Endpoint
	│   ├── css                           - CSS Code
	│   ├── js                            - JS Code
	│   ├── less                          - LESS Code
	│   │   ├── _imported.less            - Exclude '_' prefixed files
	│   │   └── app.less
	│   └── templates                     - Handlebar Templates
	├── test                              - Tests
	└── plugins                           - Bower Install Directory
	
	
Build Process
-------------
The build process does the following

1. Wipes the `dist` directory.
2. Copies over files from the `bower` dependencies in the `plugins` directory.
3. Copies over non-compilable code from `src`. This includes:
	1. Javascript files from `src/js`.
	2. CSS files from `src/css`.
	3. All assets from `src/assets`.
	4. Any file in `src`.
4. Compiles the CoffeeScript, Handlebars, and LESS files from `src` to `dist`.


Grunt Tasks
-----------

### `compile-all`
1. Compile the CoffeeScript files in `src/coffee/**/*.coffee`.
1. Compile the Handlebars files in `src/templates/**/*.handlebars`.
1. Compile the LESS files in `src/less/**/*.less`.

### `prepare`
1. Erase the `dist` folder
2. Copy over the files that won't be compiled from `src` to `dist`.
3. Copy over the `plugins` to `dist`.
4. Compiles everything using `compile-all`

### `develop` - Default
1. Start a `connect` server. The URL is: [http://127.0.0.1:8000/](http://127.0.0.1:8000/)
2. `watch` for changes to copy/recompile to update `dist`.
