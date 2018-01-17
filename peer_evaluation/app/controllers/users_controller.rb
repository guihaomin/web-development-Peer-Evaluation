class UsersController < ApplicationController
  def new
  end


  def configclass
    @user = current_user
  end

  def delgroup
    Group.destroy(params[:id])
    UserAndGroup.where(groupID: params[:id]).destroy_all
    flash[:success]= "Group has been deleted."
    Eval.where(groupID: params[:id]).destroy_all
    redirect_to manage_groups_path
  end

  def delproject
    Project.destroy(params[:id])
    Eval.where(projectID: params[:id]).destroy_all
    flash[:success]= "Project has been deleted."
    Eval.where(projectID: params[:id]).destroy_all
    redirect_to manage_projects_path
  end

  def addstudents
    if User.find_by(loginID: params[:userID])==nil
      flash[:danger] = 'Student does not exist.'
      redirect_to manage_groups_path
    else
      @user=User.find_by(loginID: params[:userID])
      #b=2/0
      g=Group.find_by(name: params[:name])
      UserAndGroup.where(userID: @user.id).to_a.each do |i|
        if Group.find(i.groupID).group_type==g.group_type
          i.groupID=g.id
          i.save
          flash[:success]= "Student information has been updated."
          redirect_to manage_groups_path
          return
        end
      end
      if (Group.find_by(name: params[:name])!=nil)
        #b=2/0
        UserAndGroup.create(userID: @user.id, groupID: g.id)
        flash[:success]= "Student information has been added."
        redirect_to manage_groups_path
      else
        redirect_to manage_groups_path
      end
    end
  end

  def createtechproject
  end

  def writeevaluation
    @eval= Eval.new
  end

  def completeevaluation
    @eval=@r=Eval.find(params[:id])
    @eval.score=params[:score].to_i
    @eval.comments=params[:comments]
    if (@eval.score !=0 && @eval.comments !="")
      @eval.save
      redirect_to current_user
    else
      flash[:danger] = 'All fields must be completed!'
      redirect_to writeevaluation_path(:ID => @eval.id)
    end
  end

  def new_project
    name=params[:name]
    type=params[:type]
    if (Group.find_by(group_type: type)!=nil && Project.find_by(name: name)==nil)
      Project.create(name: name, project_type: type)
      redirect_to manage_projects_path
    else
      name_exists = false
      Project.all.to_a.each do |p|
        if name == p.name
          name_exists = true
        end
      end
      if name_exists
        flash[:danger] = 'Project name exists.'
      else
        flash[:danger] = 'Invalid project name/type.'
      end
      redirect_to createproject_path
    end
  end

  def newgroup
    name = params[:name]
    type = params[:type]
    @group=Group.new(name: name, group_type: type)
    if @group.save
      redirect_to manage_groups_path
    else
      name_exists = false
      Group.all.to_a.each do |g|
        if @group.name == g.name
          name_exists = true
        end
      end
      if name_exists
        flash[:danger] = 'Group name exists.'
      else
        flash[:danger] = 'Invalid group name/type.'
      end
      redirect_to creategroup_path
    end
  end

  def completechange
    @user = current_user
    #b=2/0
    g = Group.find_by(name: params[:name])
    UserAndGroup.where(userID: @user.id).to_a.each do |i|
      if Group.find(i.groupID).group_type == g.group_type
        i.groupID=g.id
        i.save
        redirect_to current_user
        return
      end
    end
    if (Group.find_by(name: params[:name])!=nil)
      #b=2/0
      UserAndGroup.create(userID: @user.id, groupID: g.id)
      redirect_to current_user
    else
      render 'changegroup'
    end
  end

  def changegroup
  end

  def writeeva
    @user = User.find(params[:student])
  end

  def show
    if logged_in?
      @user = current_user
      #only call sync when rendering a user page to avoid repetition.
      sync_info
      if @user.user_type == 'instructor'
        redirect_to instructor_url :instructor => @user
      end
    else
      redirect_to root_url
    end
  end

  def create
    @user = User.new(params.require(:user).permit!)
    @user.user_type = 'student'
    if @user.save
      log_in @user
      redirect_to @user
      #@b=3/0
    else
      flash[:danger] = 'Invalid ID/password'
      redirect_to register_path
    end
  end

  def destroy
    @user = User.find(params[:id])
    if (current_user.user_type == "student")
      log_out
      Eval.where(writerID: @user.id).to_a.each do |e|
        e.destroy
      end
      Eval.where(recieverID: @user.id).to_a.each do |e|
        e.destroy
      end
      UserAndGroup.where(userID: @user.id).destroy_all
      @user.destroy
      redirect_to "/login"
    else
      Eval.where(writerID: @user.id).to_a.each do |e|
        e.destroy
      end
      Eval.where(recieverID: @user.id).to_a.each do |e|
        e.destroy
      end
      UserAndGroup.where(userID: @user.id).destroy_all
      @user.destroy
      redirect_to "/users"

    end

    flash[:success] = "User Deleted!"
  end

  def update
    @user=User.find(params[:id])

    if @user.update(params.require(:user).permit!)
      redirect_to @user
      #@b=3/0
    else
      render 'register'
    end
  end

  def manage_groups
    @group_type=[]
    @a=[]
    Group.all.to_a.each do |g|
      if !@group_type.include?(g.group_type)
        @group_type.push(g.group_type)
      end
    end
    @group_type.each do |t|
      @a.push(Group.where(group_type: t))
    end
  end

  def manage_projects
    @project_type=[]
    @a=[]
    Project.all.to_a.each do |p|
      if !@project_type.include?(p.project_type)
        @project_type.push(p.project_type)
      end
    end
    @project_type.each do |t|
      @a.push(Project.where(project_type: t))
    end
  end

  private def eval_params
    params.require(:eval).permit(:comments, :score)
  end
  private def sync_info
    u=[]
    #access eval table from user to avoid unnecessary query of each record
    UserAndGroup.all.to_a.each do |r|
      if !u.include?(r.userID)
        u.push(r.userID)
      end
    end
    u.each do |user|
      t=[]
      UserAndGroup.all.to_a.each do |r|
        if (!t.include?(Group.find(r.groupID).group_type) && r.userID==user)
          t.push(Group.find(r.groupID).group_type)
        end
      end
      project=[]
      
      Project.all.to_a.each do |p|
        if t.include? p.project_type
          project.push(p.id)
        end
      end
      
      #scan eval
      project.each do |item|
        if Eval.where(projectID: item, writerID: user).to_a.length==0 #project not found in eval sync started
          pType=Project.find(item).project_type
          Group.where(group_type:Project.find(item).project_type).to_a.each do |g|
            if UserAndGroup.find_by(groupID: g.id, userID: user)!=nil
              peers=find_all_users(g.id)
              peers2=find_all_users(g.id)
              peers.each do |p1|
                peers2.each do |p2|
                  if Eval.find_by(writerID: p1, recieverID: p2, projectID: item)==nil
                    Eval.create(writerID: p1, recieverID: p2, projectID: item, groupID: g.id)
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  private def user_params
    params.require(:user).permit!
  end


end
