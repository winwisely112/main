package memory

import (
	"context"
	"sync"
	"time"

	"github.com/golang/protobuf/ptypes"
	guuid "github.com/google/uuid"
	v1 "github.com/winwisely99/main/server/packages/document/api/v1"
)

// Memory structure used as in memory database for development only
type Memory struct {
	Documents map[string][]*v1.Document
	sync.Mutex
}

// Close repository
func (m *Memory) Close() {
}

// New Document
func (m *Memory) New(ctx context.Context, userID string, document *v1.Document) (*v1.Document, error) {

	updatedTimeStamp, _ := ptypes.TimestampProto(time.Now())

	document.Id = guuid.New().String()
	document.LastUpdate = updatedTimeStamp
	document.Conflict = v1.ConflictStatus_SYNC

	docs, ok := m.Documents[userID]

	if !ok {
		m.Documents[userID] = []*v1.Document{document}
	} else {
		docs = append(docs, document)
		m.Documents[userID] = docs
	}

	return document, nil
}

// Merge Document
func (m *Memory) Merge(ctx context.Context, userID string, document *v1.Document) (*v1.Document, error) {

	docs, ok := m.Documents[userID]

	if !ok {
		return m.New(ctx, userID, document)
	}

	for i, d := range docs {
		if d.GetId() == document.GetId() {
			updatedTimeStamp, _ := ptypes.TimestampProto(time.Now())
			document.LastUpdate = updatedTimeStamp
			document.Conflict = v1.ConflictStatus_SYNC
			docs[i] = document
		}
	}

	m.Documents[userID] = docs
	return document, nil
}

// List Documents
func (m *Memory) List(ctx context.Context, userID string) ([]*v1.Document, error) {

	docs, ok := m.Documents[userID]

	if !ok {
		return []*v1.Document{}, nil
	}

	return docs, nil
}

// Sync Documents
func (m *Memory) Sync(ctx context.Context, userID string, document *v1.Document) (string, error) {

	m.Lock()
	defer m.Unlock()

	for i, doc := range m.Documents[userID] {
		if doc.GetLocalId() == document.GetLocalId() {
			if document.GetId() == "" {
				document.Id = doc.GetId()
			}
			m.Documents[userID][i] = document
		}
	}
	return document.Id, nil
}
