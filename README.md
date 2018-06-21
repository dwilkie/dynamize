# Dynamizer

[![Build Status](https://travis-ci.org/dwilkie/dynamizer.svg?branch=master)](https://travis-ci.org/dwilkie/dynamizer)

Make your static site dynamic. Works well with [Github Pages](https://pages.github.com/) and [Travis](https://travis-ci.org/).

*This [README](https://github.com/dwilkie/dynamizer/blob/master/README.md) was generated by [Dynamizer](https://github.com/dwilkie/dynamizer) on 21 June 2018. The source template can be found [here](https://github.com/dwilkie/dynamizer/blob/master/examples/templates/README.md.erb).*

## Features

* Uses [ERB](http://ruby-doc.org/stdlib/libdoc/erb/rdoc/ERB.html) to dynamize your static content
* Includes a sample [.travis.yml](https://github.com/dwilkie/dynamizer/blob/master/.travis.yml) configuration file for updating content from a Travis build which can be triggered from a [Cron Job](https://docs.travis-ci.com/user/cron-jobs/).

## Usage

The following command mounts [./examples/templates](https://github.com/dwilkie/dynamizer/tree/master/examples/templates), [./examples/renderers](https://github.com/dwilkie/dynamizer/tree/master/examples/renderers), [./examples/data](https://github.com/dwilkie/dynamizer/tree/master/examples/data) and [.](https://github.com/dwilkie/dynamizer) to the container and runs `rake dynamizer:dynamize`.

```
$ docker run --rm -v $(pwd)/examples/templates:/tmp/dynamizer_templates:ro -v $(pwd)/examples/renderers:/tmp/dynamizer_renderers:ro -v $(pwd)/examples/data:/tmp/dynamizer_data:ro -v $(pwd):/tmp/dynamizer_output dwilkie/dynamize /bin/sh -c "bundle exec rake dynamizer:dynamize"
```

Dynamizer takes the files in the [templates directory](https://github.com/dwilkie/dynamizer/tree/master/examples/templates) and writes the output to [.](https://github.com/dwilkie/dynamizer) using the [renderers](https://github.com/dwilkie/dynamizer/tree/master/examples/renderers).

See the [examples](https://github.com/dwilkie/dynamizer/tree/master/examples) for more info. For a more complex example including how to add your own dependencies to the renderers see [here](https://github.com/somleng/somleng-project/blob/master/.travis.yml)

## Deployment

### Generate a new SSH Key

[Generate a new SSH Key](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/) for Travis and add the public key to the deploy keys for your repo. Remember to select read/write access.

```
$ ssh-keygen -t rsa -b 4096 -C "deploy@travis-ci.org" -f dynamizer-travis -q -N ""
```

### Encrypt the private key

Encrypt the private key [with Travis](https://docs.travis-ci.com/user/encrypting-files/) and add it to the repo. Remove the unencrypted ssh keys
```
$ travis encrypt-file dynamizer-travis
$ git add dynamizer-travis.enc
$ rm dynamizer-travis dynamizer-travis.pub
```

### Add the decryption command to your .travis.yml file

Edit your [.travis.yml](https://github.com/dwilkie/dynamizer/blob/master/.travis.yml) configuration file and replace the following with the output from the step above.

```
openssl aes-256-cbc -K $encrypted_28362f02a9a2_key -iv $encrypted_28362f02a9a2_iv -in dynamizer_deploy.enc -out deploy_key -d
```

See also [this article](https://gist.github.com/domenic/ec8b0fc8ab45f39403dd)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dwilkie/dynamizer.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
