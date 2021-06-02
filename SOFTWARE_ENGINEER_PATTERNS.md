## References

### How to manage/plan tasks? 

One of the best ways to stay organized at work is with a well-structured plan. A personal task management plan helps you to meet your deadlines – and help others meet theirs. 

- Rework big goals into small objectives
  - Large scale goal: learn to swim; smaller objectives: learn to inhale and exhale into the water, learn to float, learn to kick and so on...
- Clarify objectives by converting them into a series of tasks
  - Objective: learn to inhale and exhale into the water; Taks: breathing train for 10 min out of the water, breathing train for 10 min into the water and so on..
 
### [The best gitflow](https://www.atlassian.com/br/git/tutorials/comparing-workflows/gitflow-workflow)

In even the smallest development projects, developers are often required to work on multiple components in parallel. Feature X, bug #102, a new UI for a sign-up form, etc.
Among many others issues, imagine these scenarios:

- Your client tells you that they don’t want feature X anymore.
- Or what if you find that feature Y — an experimental feature you have been working on — can’t be implemented?

How do you get code removed safely from your code base?

Using branches is the solution to these commonplace development problems.

Not convinced yet? you should read [it](https://www.webfx.com/blog/web-design/why-you-should-use-git/)

### How to manage/plan tasks _gitflowly_?

In this plan, each task/series of tasks has its respective branch in a given repository. The task will be classified as a _feature_/_hotfix_/_release_ branch depending on what it is about.

Then, the task life cycle will follow a branch life cycle:
- Merged branches are _Done_ tasks
- Open issues without branches are _ToDo_ tasks
- Active branches are _Doing_ tasks


### Best practices to high quality code

- **Practice test driven develop**: code should have unit testing with at least 50% overall code coverage.
- **Team/Pair Programming**: code should be reviewed because it encourages discussion of code design 
- **Exception Handling**: code should handle exceptions to avoid retrieve errors to client
- **Keep It Simple Stupid**: simple code is elegant and can be harder to write but easier to maintain and understand
- **Use appropriate logging levels**: appropriate logging levels helps admins and developers deal with log messages appropriately

### Extra

- Why you should use docker for data science? [here](https://medium.com/analytics-vidhya/why-you-should-use-docker-to-simplify-data-science-machine-learning-development-environment-d6a1188d8ee1#:~:text=Using%20Docker%20in%20Data%20Science,one%20environment%20breaking%20other%20environments.) and [here](https://blog.dsbrigade.com/docker-para-ciencia-de-dados/)
