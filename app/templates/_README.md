# <%= projectName %>

**This is a small collection of minifiers that are comprised of followings:**

- concat
- uglify
- cssmin
- usemin
- imagemin

- No test framework is set up yet. It's still under development.

## Installation dependencies if necessary

### Install Node modules if the initial installation failed

```
$ npm install
```

## Grunt Tasks

### Default

```
$ grunt
```

- Alias task of `build`

### Build

```
$ grunt build
```

- Minify JavaScript, Stylesheet, HTML and image files in the `src` directory
- Output all processed files into the `dist` directory
