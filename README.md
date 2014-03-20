# uSport
Sports events crowdcasting web app.

## Warning
Migration from [bitbucket repo](http://bitbucket.org/embs/usport) is still a
work in progress. Shout it if you can help.

## Wiki
Still in this old fashioned and portuguese domain right [here](https://bitbucket.org/embs/usport/wiki/Home).

## Known issues
Still in this old fashioned and portuguese domain right [here](https://bitbucket.org/embs/usport/issues).

## Run specs
```shell
$ rake db:create:all
$ rake db:migrate
$ rake db:test:prepare
$ rspec
```

### Dev environment Delayed::Job
```bash
$ foreman start
```

## Contributing
Hands on!

## License
The MIT License (MIT)

Copyright (c) [2014] [uSport]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
