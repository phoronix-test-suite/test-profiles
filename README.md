# Phoronix Test Suite / OpenBenchmarking.org Test Profiles

This Git repository serves as an auto-converted repository of all [OpenBenchmarking.org](http://www.openbenchmarking.org/) test profiles used by the [Phoronix Test Suite](http://www.phoronix-test-suite.com/) available in the form of a Git repository. OpenBenchmarking.org test profiles themselves are not stored in any Git repository but rather has relied upon its own custom version management system integrated into the Phoronix Test Suite. (This Git copy is auto-generated via `phoronix-test-suite dump-tests-to-git`.) This Git repository is here primarily for _convenience_.

These test profiles are not usable without the [Phoronix Test Suite](http://www.phoronix-test-suite.com/) or from [its Git repository](https://github.com/phoronix-test-suite/phoronix-test-suite). Since Phoronix Test Suite 3.0, test profiles have been versioned separately from the Phoronix Test Suite and served by OpenBenchmarking.org when needed by the client, rather than being bundled with the phoronix-test-suite package itself. This allows for test profiles to be updated independent of the Phoronix Test Suite client, new tests to be added past a Phoronix Test Suite release, and other benefits. The Phoronix Test Suite checks for new test profiles/suites on a daily basis when run, though the meta-data cache can be updated manually if desired via `phoronix-test-suite openbenchmarking-refresh`. The `phoronix-test-profile openbenchmarking-changes` sub-command also provides users from the CLI a convenient look at recently updated tests.

A test profile itself consists of a main XML file containing the test's meta-data (_test-definition.xml_), an XML file if needed to specify required files and its MD5/SHA256 hashes and file sizes (_downloads.xml_), and the _install.sh_ script for installing the test and generating the run-script for execution by the Phoronix Test Suite at run-time. There are also other potential files like _pre.sh_, _interim.sh_, and _post.sh_ for execution at pre-run, interim-run, and post-run stages by the Phoronix Test Suite. 

If you are looking to get involved with test profile development, the simplest way is by starting at looking at a basic test like _c-ray_, _tesseract_ or others. Simply run _phoronix-test-suite benchmark tesseract_ and then look at the test profile's contents either via this Git repository or by the default locations in _~/.phoronix-test-suite/test-profiles_ or _/var/lib/phoronix-test-suite/test-profiles/_ if running as root. More documentation on test profile development will come in the future, but happy to answer any questions that may emerge and are not covered by documentation.

## Purpose

**The purpose of this Git repository is to satisfy those wanting a Git-based workflow around test profile development and updating. As well, for making use of GitHub's infrastructure if desired for reporting any test profile issues/bugs or submitting pull requests.** Pull requests won't directly be used but any accepted changes will be applied to the OpenBenchmarking.org test profiles appropriately and will then appear back into this Git repository when updated by the PTS administrator.

If you want to submit your own OpenBenchmarking.org test profiles directly, that can always be done by creating an OpenBenchmarking.org account and then uploading any new/modified test profiles to your account using the `phoronix-test-suite upload-test-profile <test identifier>` sub-command.

## Why OpenBenchmarking.org Doesn't Use Git For Tests

Among the reasons for not using Git as the primary form of test profile hosting for OpenBenchmarking.org includes:

* The Phoronix Test Suite / OpenBenchmarking.org philosophy **mandates that with any change, a new version of the test profile be tagged**. This is done for reproducibility and being able to ensure the exact test profile state when a set of tests are conducted. Test profiles are versioned in a _test-X.Y.Z_ format where _X_ or _Y_ are bumped whenever a change is made to the test profile that makes the results incomparable to a previous version of the tests (e.g. updating against a new upstream code-base, adjusting the parameters to what is benchmarked, etc). The Phoronix Test Suite then knows not to attempt any comparisons with an incompatible version difference or to go and fetch that specific version of the package. The _Z_ is bumped when just making non-important changes such as just updating the test's meta-data, changing download URLs, etc. This is easy to enforce with the OpenBenchmarking.org infrastructure rather than having to worry about non-human-friendly Git hashes as test profile versions or having to create Git tags after every commit. The test profile version can optionally be specified when running a test, e.g. `phoronix-test-suite benchmark scimark2-1.2.1` instead of `phoronix-test-suite benchmark scimark2`, which would by default choose the latest available test profile version from OpenBenchmarking.org. The test profile versions are also always written out as part of the Phoronix Test Suite result XML data.

* With the OpenBenchmarking.org infrastructure, Phoronix Test Suite / [Phoromatic](http://www.phoromatic.com/) clients can simply request from the server a packaged archive of the desired test profiles/suites without needing Git present on the client systems. The Phoronix Test Suite seeks to have minimal system dependencies itself, rarely requiring anything outside core PHP, and thus avoid the dependency on `git`.

* Simplicity and many test profiles seeing updates only a few times per year or less while being maintained by a small number of individuals.

* Each test profile would need its own Git repository with each test being independently versioned, separate from other tests or the Phoronix Test Suite itself.

* The majority of the OpenBenchmarking.org infrastructure was written in 2010 and has served its purpose fine without any problems, thus not any need to re-engineer something that has been working effectively for its purpose.

## Questions?

Contact _commercial at phoronix-test-suite.com_ or open a ticket via this GitHub repository.
