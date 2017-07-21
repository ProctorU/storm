module Users
  # InvitationsController
  class InvitationsController < Devise::InvitationsController
    layout('application')

    private

    def invite_resource(&block)
      # find all users, including unscoped (deleted).
      @user = User.unscoped.find_by(email: invite_params[:email])

      # only re-invite if user has been deleted.
      if @user && @user.deleted? && @user.email != current_user.email
        @user.assign_attributes(
          reinvite_attributes.merge(skip_invitation_params)
        )
        @user.invite!(current_user)
        @user
      else
        # instance method, invite!, returns a User instance
        resource_class.invite!(
          invite_params.merge(skip_invitation_params),
          current_inviter,
          &block
        )
      end
    end

    def after_invite_path_for(_inviter, invitee)
      users_invitations_instructions_path(
        id: invitee.id,
        token: invitee.raw_invitation_token
      )
    end

    def reinvite_attributes
      {
        deleted_at: nil # "un-delete" a deleted user.
      }
    end

    def skip_invitation_params
      {
        skip_invitation: true # don't send an email.
      }
    end
  end
end
