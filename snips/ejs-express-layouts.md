# ejs-express-layouts

http://hectorcorrea.com/#/blog/using-layouts-with-ejs-in-express-3-x/31

```
app.engine('.html', require('ejs').__express);
app.set('views', __dirname + '/views');
app.set('view engine', 'html');
```