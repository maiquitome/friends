defmodule Friends.Person do
  use Ecto.Schema
  # import Ecto.Changeset

  Ecto.Schema.schema "people" do
    field :name,  :string
    field :age,   :integer, default: 0
  end

  @fields_allowed_for_changes [:name, :age]
  @required_fields [:name]

  def changeset(struct_with_original_data, map_with_changes) do
    # Para criar um changeset usando o schema Person, vamos usar Ecto.Changeset.cast/3:
    struct_with_original_data
    |> Ecto.Changeset.cast(map_with_changes, @fields_allowed_for_changes)
    |> Ecto.Changeset.validate_required(@required_fields)
    |> Ecto.Changeset.validate_inclusion(:name, ["north", "east", "south", "west"])
    # |> validate_fictional_name()
    # |> Ecto.Changeset.validate_length(:name, min: 2)
  end

  @fictional_names ["Black Panther", "Wonder Woman", "Spiderman"]
  def validate_fictional_name(changeset) do
    name = Ecto.Changeset.get_field(changeset, :name)

    if name in @fictional_names do
      changeset
    else
      Ecto.Changeset.add_error(changeset, :name, "is not a superhero")
    end
  end

  def set_name_if_anonymous(changeset) do
    name = Ecto.Changeset.get_field(changeset, :name)

    # Às vezes você quer introduzir mudanças em um changeset manualmente.
    # O put_change/3 existe para este propósito.
    if is_nil(name) do
      Ecto.Changeset.put_change(changeset, :name, "Anonymous")
    else
      changeset
    end
  end

  # Nós podemos definir o nome do usuário como “Anonymous”, apenas quando se registrar na aplicação; para fazer isso, vamos criar uma nova função de changeset:
  def registration_changeset(struct, params) do
    struct
    |> Ecto.Changeset.cast(params, [:name, :age])
    |> set_name_if_anonymous()
  end

  # Tendo uma função changeset que tem uma responsabilidade específica (como registration_changeset/2) não é incomum — às vezes, você precisa da flexibilidade para executar apenas algumas validações ou filtrar parâmetros específicos. A função acima poderia ser usada em um sign_up/1 dedicado em outro lugar:

  # def sign_up(params) do
  #   %Friends.Person{}
  #   |> Friends.Person.registration_changeset(params)
  #   |> Repo.insert()
  # end
end
