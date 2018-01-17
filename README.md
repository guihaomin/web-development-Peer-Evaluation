# Project6-Seg-Faults
## Goals
A very intuitive peer evaluation application which provides a solution for any classes or companies that have groups project and need peer evaluation. 
## Running command
First run `rake db:create && rake db:schema:load` to initialize database.
Then run `rails s` to start server
To add an instructor go to rails console 'rails c' and type User.create(loginID:"giles.1", name:"Charles Giles", user_type:"instructor", password:"apples")
## Location
The home page of peer evaluation located in `localhost:3000`.
## Functionality
On the user end, first register a account, then a page is rendered for user to write pending evaluation and review peer evaluation.
Instructor on the other hand can manage groups and projects. Management options include creating group/project, deleting group/project, putting user into groups and deleting user. Additioanlly, instructor can review all student evaluation on his home page.
## Feature
1. security: All users can only visit his own page after logging into his session.
2. Flexibility: App can handle different situation and unusual user behaviour.
3. Clean and organized page design.
4. All-rounded functions: Support switching group from both student and instructor end; Support infinite types of group; Support deletion of groups or project as well as users.

## Contribution(Sorted by name):
- Basel Abdel-Rahman: Log in/out(password), User setting, User control, CSS/Styling of website, model(Made a important decision of giving up implementing relation so everything can go, thanks!).
- Danny Martinus: About page, Contact page CSS/Styling/content, all tests(controller/model/view), discussion in model, footer of website.
- Haomin Gui: Session, pending evaluation and creating/updating/showing group/project in instructor page.
- Jarvis Huang: new model idea, origin management page of project/group, CSS/Styling of website, clean bugs of website and old migration files.
