##############
IS 210 Testing
##############

:College: CUNY School of Professional Studies
:Course-Name: Software Application Programming I
:Course-Code: IS 210

********
Overview
********

This repository provides the Docker testing harness for student-submitted
work to *IS 210: Software Application Programming I*. This harness may be
used by Jenkins to provide automated software testing for IS 210 code

************
Requirements
************

You must have a recent docker installed in order to run tests through this
script. All other requirements are handled inside Docker directly.

***********
Preparation
***********


Build your test image through ``docker build`` and give it a meaningful tag.
For the purposes of this documentation, our tag will be ``is210``.

.. code:: console

    $ docker build -t is210 ./

*************
Running Tests
*************

Tests are automatically run upon execution of the environment. Source code
should be mounted to the ``$WORKSPACE`` directory (as set in the
environmental variable). By default, it assumes tests are in the root of the
source code repository in a directory named ``tests``. See the environment
variables sections for more details.

Basic Execution
===============

.. code:: console

    $ docker run -v /my/source/directory:/var/workspace is210

Environment Variables
=====================

The following environment variables can be used to tune execution, notably,
to move the location of tests, if so desired.

.. note::

    While not explicitly exposed in the Dockerfile, the nosetests executable
    used in unit testing has many of its core execution parameters also
    exposed via environment variables. See the nosetests documentation for
    more information:

    http://nose.readthedocs.org/en/latest/usage.html

.. table:: Environment Variables

    =========== =================== ===========================================
    Variable    Default             Usage
    =========== =================== ===========================================
    WORKSPACE   /var/workspace      source code to be tested
    APPFILES    /application        test support files
    PYTHONPATH  $APPFILES/python    additional modules for PYTHONPATH
    PYLINTRC    $APPFILES/pylintrc  pylint configuration file
    TESTDIR     $WORKSPACE/tests    location of tests to be run
    LOGDIR      /var/log            location where logs will be stored
    =========== =================== ===========================================
