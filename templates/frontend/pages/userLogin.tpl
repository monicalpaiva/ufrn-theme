{**
 * templates/frontend/pages/userLogin.tpl
 *
 * Copyright (c) 2014-2018 Simon Fraser University
 * Copyright (c) 2000-2018 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * User login form.
 *
 *}
{include file="frontend/components/header.tpl" pageTitle="user.login"}

<div class="page page_login">
	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="user.login"}

	{* A login message may be displayed if the user was redireceted to the
	   login page from another request. Examples include if login is required
	   before dowloading a file. *}
	{if $loginMessage}
		<p>
			{translate key=$loginMessage}
		</p>
	{/if}

	<div class="d-flex justify-content-center">
		<form class="cmp_form login login_ufrn_theme col-md-4 col-sm-12" id="login" method="post" action="{$loginUrl}">
			{csrf}

			{if $error}
				<div class="pkp_form_error">
					{translate key=$error reason=$reason}
				</div>
			{/if}

			<input type="hidden" name="source" value="{$source|strip_unsafe_html|escape}" />

			<fieldset class="fields">
				<div class="username">
					<label>
						<span class="label">
							{translate key="user.username"}
							<span class="required">*</span>
							<span class="pkp_screen_reader">
								{translate key="common.required"}
							</span>
						</span>
						<input type="text" name="username" id="username" class="form-control" value="{$username|escape}" maxlength="32" required>
					</label>
				</div>
				<div class="password">
					<label>
						<span class="label">
							{translate key="user.password"}
							<span class="required">*</span>
							<span class="pkp_screen_reader">
								{translate key="common.required"}
							</span>
						</span>
						<input type="password" name="password" id="password" class="form-control" value="{$password|escape}" password="true" maxlength="32" required>
						<a href="{url page="login" op="lostPassword"}">
							{translate key="user.login.forgotPassword"}
						</a>
					</label>
				</div>
				<div class="remember checkbox pb-1">
					<label>
						<input type="checkbox" name="remember" id="remember" value="1" checked="$remember">
						<span class="label">
							{translate key="user.login.rememberUsernameAndPassword"}
						</span>
					</label>
				</div>
				<div class="buttons">
					<button class="btn btn-primary btn-block mb-2" type="submit">
						{translate key="user.login"}
					</button>

					{if !$disableUserReg}
						{capture assign=registerUrl}{url page="user" op="register" source=$source}{/capture}
						<a href="{$registerUrl}" class="register">
							{translate key="user.login.registerNewAccount"}
						</a>
					{/if}
				</div>
			</fieldset>
		</form>
	</div>
</div><!-- .page -->

{include file="frontend/components/footer.tpl"}
