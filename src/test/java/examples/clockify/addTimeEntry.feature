Feature: clockify tests projects

  Background: Headers and URL
    Given url urlBase
    And header x-api-key = ''


 @TimeEntry
  Scenario Outline: Crear time entry
    * def body = read('classpath:examples/clockify/request/addTime.json')
    And path 'workspaces/<workspaceId>/time-entries'
    And request body
    When method POST
    Then status 201
   * def id = response.id

    Examples:
      | workspaceId              |
      | 6523381733ae762f43636497 |


