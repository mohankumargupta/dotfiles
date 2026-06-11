1. when creating python project with uv init someproject, 
   remember to cd someproject and do a uv sync so that it creates a .venv file

   When you don't do uv sync, you will get error. You can diagnose it by
   opening emacs, run Alt-x toggle-debug-on-error then opening file, you will see 
   python problem.

