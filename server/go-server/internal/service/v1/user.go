package v1

import (
	"context"
	"errors"
	"fmt"
	"strconv"

	"github.com/golang/protobuf/ptypes/empty"
	v1 "github.com/winwisely99/main/server/go-server/internal/api/v1"
)

// userServiceServer is implementation of v1.usertServiceServer proto interface
type userServiceServer struct {
	users map[string]*v1.User
}

// NewUserServiceServer creates user service object
func NewUserServiceServer() v1.UserServiceServer {
	return &userServiceServer{
		make(map[string]*v1.User),
	}
}

// SignUp register a new user
func (u *userServiceServer) SignUp(ctx context.Context, in *v1.UserSignUp) (*empty.Empty, error) {

	// Add a new user
	id := strconv.Itoa(len(u.users))

	user := &v1.User{
		Id:           id,
		FirstName:    in.FirstName,
		LastName:     in.LastName,
		Email:        in.Email,
		DisplayName:  in.DisplayName,
		AvatarURL:    "",
		ChatgroupIds: []string{},
	}

	// Check if user is already registred if not add the user
	if _, ok := u.users[in.Email]; !ok {
		u.users[in.Email] = user
		fmt.Println("registred a new user")
	}

	return &empty.Empty{}, nil
}

// SignIn signin user
func (u *userServiceServer) SignIn(ctx context.Context, in *v1.UserSignIn) (*v1.User, error) {

	// Check if user is already registred
	if user, ok := u.users[in.Email]; ok {
		return user, nil
	}

	return nil, errors.New("User does not exists")
}
