Chitcom Website
===============

Chitcom Website Alpha

.. image:: https://img.shields.io/badge/code%20style-black-000000.svg
     :target: https://github.com/ambv/black
     :alt: Black code style


Basic Commands
--------------
Build
::

  $ docker-compose -f local.yml build

Run
::

  $ docker-compose -f local.yml up

Run tests
::

  $ docker-compose -f local.yml run django pytest

To run project locally use first 2 commands.

Type checks
^^^^^^^^^^^

Running type checks with mypy:

::

  $ mypy chitweb

Test coverage
^^^^^^^^^^^^^

To run the tests, check your test coverage, and generate an HTML coverage report::

    $ coverage run -m pytest
    $ coverage html
    $ open htmlcov/index.html

For more info
^^^^^^^^^^^^^
Check out @chitcom