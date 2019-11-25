package v1

import (
	"context"
	"errors"
	"fmt"
	"log"
	"time"

	"github.com/golang/protobuf/ptypes"
	"github.com/golang/protobuf/ptypes/empty"
	guuid "github.com/google/uuid"
	v1 "github.com/winwisely99/main/server/go-server/internal/api/v1"
)

type newsServiceServer struct {
	newsList []*v1.News
	news     chan *v1.News
}

// NewNewsServiceServer creates news service object
func NewNewsServiceServer() v1.NewsServiceServer {
	return &newsServiceServer{
		news: make(chan *v1.News, 1000),
	}
}

// AddNews allows to add a news
func (n *newsServiceServer) AddNews(ctx context.Context, newNews *v1.NewNews) (*empty.Empty, error) {

	if newNews != nil {
		log.Println("New news")

		newsTimeStamp, _ := ptypes.TimestampProto(time.Now())
		news := &v1.News{
			Id:           guuid.New().String(),
			Title:        newNews.Title,
			Text:         newNews.Text,
			ThumbnailUrl: newNews.ThumbnailUrl,
			Timestamp:    newsTimeStamp,
			Uid:          newNews.Uid,
		}

		n.newsList = append(n.newsList, news)

		n.news <- news

	} else {
		log.Println("New news")
	}

	return &empty.Empty{}, nil
}

// GetNewsID is method to get news by id
func (n *newsServiceServer) GetNewsID(ctx context.Context, req *v1.RequestNewsID) (*v1.News, error) {

	for _, news := range n.newsList {
		if news.Id == req.Id {
			return news, nil
		}
	}

	return nil, fmt.Errorf("News with id: \"%s\" does not exists", req.Id)
}

// StreamNews is streaming method to get news from the server
func (n *newsServiceServer) StreamNews(e *empty.Empty, stream v1.NewsService_StreamNewsServer) error {

	log.Println("Subscribe to news stream")
	return n.brodcast(stream)
}

// Brodcast news to a client
func (n *newsServiceServer) brodcast(stream v1.NewsService_StreamNewsServer) error {

	for {
		select {

		case news := <-n.news:
			if err := stream.Send(news); err != nil {
				n.news <- news
				return errors.Unwrap(err)
			}
			log.Println("Message sent:", news)
		}
	}
}
