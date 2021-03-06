<%--
/**
 * Copyright (c) 2000-2013 Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */
--%>

<%@ include file="/html/taglib/init.jsp" %>

<%
String bodyLabel = (String)request.getAttribute("liferay-ui:email-notification-settings:bodyLabel");
String emailBody = (String)request.getAttribute("liferay-ui:email-notification-settings:emailBody");
Map<String, String> emailDefinitionTerms = (Map<String, String>)request.getAttribute("liferay-ui:email-notification-settings:emailDefinitionTerms");
boolean emailEnabled = GetterUtil.getBoolean((String)request.getAttribute("liferay-ui:email-notification-settings:emailEnabled"));
String emailParam = (String)request.getAttribute("liferay-ui:email-notification-settings:emailParam");
String emailSubject = (String)request.getAttribute("liferay-ui:email-notification-settings:emailSubject");
String fieldPrefix = (String)request.getAttribute("liferay-ui:email-notification-settings:fieldPrefix");
String fieldPrefixSeparator = (String)request.getAttribute("liferay-ui:email-notification-settings:fieldPrefixSeparator");
String helpMessage = (String)request.getAttribute("liferay-ui:email-notification-settings:helpMessage");
boolean showEmailEnabled = GetterUtil.getBoolean(request.getAttribute("liferay-ui:email-notification-settings:showEmailEnabled"));
boolean showSubject = GetterUtil.getBoolean(request.getAttribute("liferay-ui:email-notification-settings:showSubject"));
%>

<aui:fieldset>
	<c:if test="<%= showEmailEnabled %>">
		<aui:input label="enabled" name='<%= fieldPrefix + fieldPrefixSeparator + emailParam + "Enabled" + fieldPrefixSeparator %>' type="checkbox" value="<%= emailEnabled %>" />
	</c:if>

	<c:if test="<%= showSubject %>">
		<c:choose>
			<c:when test="<%= Validator.isNotNull(emailSubject) && Validator.isXml(emailSubject) %>">
				<aui:field-wrapper label="subject">
					<liferay-ui:input-localized
						fieldPrefix="<%= fieldPrefix %>"
						fieldPrefixSeparator="<%= fieldPrefixSeparator %>"
						name='<%= emailParam + "Subject" %>'
						xml="<%= emailSubject %>"
					/>
				</aui:field-wrapper>
			</c:when>
			<c:otherwise>
				<aui:input cssClass="lfr-input-text-container" label="subject" name='<%= fieldPrefix + fieldPrefixSeparator + emailParam + "Subject" + fieldPrefixSeparator %>' value="<%= emailSubject %>" />
			</c:otherwise>
		</c:choose>
	</c:if>

	<aui:field-wrapper helpMessage="<%= helpMessage %>" label="<%= bodyLabel %>">
		<c:choose>
			<c:when test="<%= Validator.isNotNull(emailBody) && Validator.isXml(emailBody) %>">
				<liferay-ui:input-localized
					fieldPrefix="<%= fieldPrefix %>"
					fieldPrefixSeparator="<%= fieldPrefixSeparator %>"
					name='<%= emailParam + "Body" %>'
					type="editor"
					xml="<%= emailBody %>"
				/>
			</c:when>
			<c:otherwise>
				<liferay-ui:input-editor editorImpl="<%= EDITOR_WYSIWYG_IMPL_KEY %>" initMethod='<%= "init" + emailParam + "BodyEditor" %>' name="<%= emailParam %>" />

				<aui:input name='<%= fieldPrefix + fieldPrefixSeparator + emailParam + "Body" + fieldPrefixSeparator %>' type="hidden" />

				<aui:script>
					function <portlet:namespace />init<%= emailParam %>BodyEditor() {
						return "<%= UnicodeFormatter.toString(emailBody) %>";
					}
				</aui:script>
			</c:otherwise>
		</c:choose>
	</aui:field-wrapper>
</aui:fieldset>

<c:if test="<%= (emailDefinitionTerms != null) && !emailDefinitionTerms.isEmpty() %>">
	<aui:fieldset cssClass="definition-of-terms" label="definition-of-terms">
		<dl>

			<%
			for (Map.Entry<String, String> entry : emailDefinitionTerms.entrySet()) {
			%>

				<dt>
					<%= entry.getKey() %>
				</dt>
				<dd>
					<%= entry.getValue() %>
				</dd>

			<%
			}
			%>

		</dl>
	</aui:fieldset>
</c:if>

<%!
public static final String EDITOR_WYSIWYG_IMPL_KEY = "editor.wysiwyg.portal-web.docroot.html.taglib.ui.email_notification_settings.jsp";
%>