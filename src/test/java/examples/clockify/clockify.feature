@Clockify
Feature: clockify tests projects

  Background: Headers and URL
    Given url urlBase
    And header x-api-key = ''

  @GetProject
  Scenario Outline: Consultar proyecto por id
    And path 'workspaces/<workspaceId>/projects/<projectId>'
    When method GET
    Then status 200
    And match response.name == 'Project2'

    Examples:
      | workspaceId              | projectId                |
      | 6523381733ae762f43636497 | 652997ce1294281e42070a72 |


  Scenario Outline: Eliminar time entry
    * def responseId = call read('classpath:examples/clockify/addTimeEntry.feature')
    * def idTimeEntry = responseId.id
    And path 'workspaces', '<workspaceId>', 'time-entries' , idTimeEntry
    When method DELETE
    Then status 204

    Examples:
      | workspaceId              |
      | 6523381733ae762f43636497 |


  Scenario Outline: Editar time entry
    * def body = read('classpath:examples/clockify/request/addTime.json')
    * set body.description = '<description>'
    * def responseId = call read('classpath:examples/clockify/addTimeEntry.feature')
    * def idTimeEntry = responseId.id
    And path 'workspaces', '<workspaceId>', 'time-entries', idTimeEntry
    And request body
    When method PUT
    Then status 200
    * print responseId

    Examples:
      | workspaceId              | description |
      | 6523381733ae762f43636497 | editado     |
