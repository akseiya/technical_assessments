Feature: Contact Us Page
  As an end user
  I want a contact us page
  So that I can find out more about QAWorks exciting services!!

  Scenario: Valid Submission
    Given that I am on the QAWorks Site
     When I fill the contact form with the following information:
        | name    | j.Bloggs                                  |
        | company | Bloggs & Froggz                           |
        | email   | j.Bloggs@qaworks.com                      |
        | message | please contact me I want to find out more |
     Then I should be able to contact QAWorks
