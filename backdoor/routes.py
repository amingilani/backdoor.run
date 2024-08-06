from flask import Blueprint, render_template, Response

root = Blueprint('main', __name__)

@root.route('/')
def main():
    return render_template('web/main.html.j2')

@root.route('/<username>')
def script_for_username(username):
    script_content = render_template('script/insert_ssh_key.sh.j2', github_username=username)
    return Response(script_content, mimetype='text/plain')
