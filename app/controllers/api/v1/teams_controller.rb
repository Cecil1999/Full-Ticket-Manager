class Api::V1::TeamsController < Api::V1::ApplicationController
  include Authenticable
  include Authorizable

  before_action :set_team, only: %i[ show update destroy ]

  def index
    render json: { r: Team.all() }
  end

  def show
    render json: { r: @team.as_json(include: { users: { only: :username } }) }
  end

  def update
    params.expect(team: [ :id, :enabled ])

    @team.enabled = true
    @team.save

    render json: { r: "Team Updated." }
  end

  def destroy
    @team.enabled = false
    @team.save
    @team.users.clear

    render json: { r: "Team successfully deleted." }
  end

  private
  def set_team
    @team = Team.find(params[:id])
  end
end
