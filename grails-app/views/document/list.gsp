<%@ page import="com.app.admin.domain.repository.Document" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'document.label', default: 'Document')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <parameter name="menu_Document" value="active" />
    </head>
    <body>
        <div class="page-header">
            <h1><i class="fa fa-briefcase"></i> <g:message code="default.management.label" args="[entityName]" /> <small><g:message code="default.list.label" args="[entityName]" /></small></h1>
        </div>
        <div class="row rowbar">
            <div class="col-md-4">
                <div id="search_bar" class="rowbar-left pull-left">
                    <g:form action="list" class="form-inline" method="GET">
                        <div class="input-group">
                            <g:textField name="q" placeholder="Text to search" value="${params.q}" elementId="appendedInputButton" class="col-md-3 form-control"/>
                            <span class="input-group-btn">
                                <button class="btn btn-default" type="button"><i class="fa fa-search"></i></button>
                                <g:render template="filter"></g:render>
                            </span>
                        </div>
                    </g:form>
                </div>
            </div>
            <div class="col-md-8">
                <div id="options_bar" class="rowbar-right pull-right">
                    <g:render template="actions" ></g:render>
                    <g:link class="btn btn-success" action="create">
                        <i class="fa fa-plus"></i>
                        <g:message code="default.create.label" args="[entityName]" />
                    </g:link>
                </div>
            </div>
        </div>
    <div class="row">
        <div class="col-md-12">

        <g:if test="${documentInstanceList}">
        <table class="table table-striped table-condensed">
            <thead>
                <tr>
                    <g:sortableColumn property="title" title="${message(code: 'document.title.label', default: 'Title')}" />
                    <th class="col-md-3"></th>
                </tr>
            </thead>
            <tbody>
            <g:each in="${documentInstanceList}" status="i" var="documentInstance">
                <tr>

                    <td>
                        <i class="fa fa-file"></i>
                        <g:link action="show" id="${documentInstance.id}">${fieldValue(bean: documentInstance, field: "title")}</g:link>  <br/>
                        <span class="text-muted">
                            ${message(code: 'document.dateCreated.label', default: 'Date Created')}: <g:formatDate date="${documentInstance.dateCreated}" /> |
                            ${message(code: 'document.lastUpdated.label', default: 'Last Updated')}: <g:formatDate date="${documentInstance.lastUpdated}" />
                        </span>
                    </td>

                    <td>
                        <div class="list-actions pull-right">
                            <span class="label">${fieldValue(bean: documentInstance, field: "category")}</span>

                            <g:link class="btn btn-default btn-xs" action="download" id="${documentInstance?.uuid}" title="${message(code: 'default.button.download.label', default: 'Download')}" rel="tooltip">
                                <i class="fa fa-download"></i>
                            </g:link>
                            <g:link class="btn btn-default btn-xs" action="show" id="${documentInstance?.id}" title="${message(code: 'default.button.show.label', default: 'Show')}" rel="tooltip">
                                <i class="fa fa-search"></i>
                            </g:link>
                            <g:link class="btn btn-default btn-xs" action="edit" id="${documentInstance?.id}" title="${message(code: 'default.button.edit.label', default: 'Edit')}" rel="tooltip">
                                <i class="fa fa-pencil"></i>
                            </g:link>
                            <g:form action="delete">
                                <g:hiddenField name="id" value="${documentInstance?.id}" />
                                <button class="btn btn-default btn-xs" type="submit" name="_action_delete" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" title="${message(code: 'default.button.delete.label', default: 'Delete')}"  rel="tooltip">
                                    <i class="fa fa-trash-o"></i>
                                </button>
                            </g:form>
                        </div>
                    </td>
                </tr>
            </g:each>
            </tbody>
            <tfooter>
                <tr>
                    <td colspan="100%">
                        <div class="pull-right">
                            <strong><g:message code="default.paginate.number" args="${[documentInstanceList?.size(),documentInstanceTotal]}"/></strong>
                        </div>
                    </td>
                </tr>
            </tfooter>
        </table>
        <div class="text-center">
            <g:paginate total="${documentInstanceTotal}" maxsteps="4" params="['q':params?.q]" />
        </div>
        </div>
        </g:if>
        <g:else>
            <g:render template="/common/empty" />
        </g:else>
        </div>
    </div>
    <g:render template="modalUpload"></g:render>
    </body>
</html>
