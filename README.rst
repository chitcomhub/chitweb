Chitcom Website
===============

Chitcom Website Alpha

.. image:: https://api.travis-ci.org/chitcomhub/chitweb.svg
     :target: https://travis-ci.org/chitcomhub/chitweb
     :alt: Build status
.. image:: https://img.shields.io/badge/code%20style-black-000000.svg
     :target: https://github.com/ambv/black
     :alt: Black code style


Basic Commands
--------------
Build
::

  $ docker-compose -f local.yml build
  OR: $ ./dev.sh build

Run
::

  $ docker-compose -f local.yml up
  OR: $ ./dev.sh up

Run tests
::

  $ docker-compose -f local.yml run django pytest
  OR: $ ./dev.sh pytest

To run project locally use first 2 commands.



For more info
^^^^^^^^^^^^^
Check out @chitcom
