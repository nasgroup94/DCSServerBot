# Extension "GitHub"
Simple extension to clone or update a given repository into a directory on your server.

## Configuration
To enable track file upload, a change in nodes.yaml is needed:
```yaml
MyNode:
  # [...]
  instances:
    DCS.release_server:
      # [...]
      extensions:
        GitHub:
          repo: 'https://github.com/mrSkortch/MissionScriptingTools.git'
<<<<<<< HEAD
=======
          branch: master  # optional branch, default is the repositories default branch (e. g. main or master)
>>>>>>> 55886799f0bf4262d5b9eca3938483610cd4460b
          target: '{server.instance.home}\Missions\Scripts'
          filter: '*.lua'
```
