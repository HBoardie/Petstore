<?php
use Behat\Gherkin\Node\PyStringNode;
use Behat\Behat\Tester\Exception\PendingException;
use Imbo\BehatApiExtension\Context\ApiContext;
use Imbo\BehatApiExtension\Exception\AssertionFailedException as Failure;

class FeatureContext extends ApiContext {
    /**
     * @Then I want to check something
     */
    public function assertSomething() {
        // do some assertions on $this->response, and throw a Failure exception is the
        // assertion fails.
    }

    /**
     * @Then the response body is
     */
    public function theResponseBodyIs(PyStringNode $string)
    {
        throw new PendingException();
    }
}
