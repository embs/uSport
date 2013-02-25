module CommentAbility
  extend ActiveSupport::Concern

  def comment_abilities(user)
    can :read, Comment # Qualquer usuário pode ler qualquer comentário

    if user
      can :create, Comment

      # Somente autores podem gerenciar seus comentários
      can :manage, Comment do |comment|
        comment.author == user
      end
    end
  end
end
