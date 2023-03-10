package s3

import (
	"context"
	"fmt"
	"io"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/s3"
	"github.com/bluearchio/Infrastructure/client"
)

type S3Service struct {
	s3 *s3.Client
}

func (e *S3Service) MPCConfig() {
	e.s3 = s3.NewFromConfig(*client.Client())
}

func (e *S3Service) CreateBucket(bucketName string) *s3.CreateBucketOutput {
	CreateBucketInput := &s3.CreateBucketInput{
		Bucket: aws.String(bucketName),
	}

	payload, error := e.s3.CreateBucket(context.TODO(), CreateBucketInput)

	if error != nil {
		fmt.Println(error)
	}

	return payload
}

func (e *S3Service) DeleteBucket(bucketName string) *s3.DeleteBucketOutput {
	DeleteBucketInput := &s3.DeleteBucketInput{
		Bucket: aws.String(bucketName),
	}

	payload, error := e.s3.DeleteBucket(context.TODO(), DeleteBucketInput)

	if error != nil {
		fmt.Println(error)
	}
	return payload
}

func (e *S3Service) ListBuckets() *s3.ListBucketsOutput {
	ListBucketsInput := &s3.ListBucketsInput{}

	payload, error := e.s3.ListBuckets(context.TODO(), ListBucketsInput)

	if error != nil {
		fmt.Println(error)
	}
	return payload
}

func (e *S3Service) PutObject(bucketName, objectName string, objectData io.Reader) *s3.PutObjectOutput {

	PutObjectInput := &s3.PutObjectInput{
		Bucket: aws.String(bucketName),
		Key:    aws.String(objectName),
		Body:   objectData,
	}

	payload, error := e.s3.PutObject(context.TODO(), PutObjectInput)

	if error != nil {
		fmt.Println(error)
	}

	return payload
}

func (e *S3Service) GetObject(bucketName, objectName string) *s3.GetObjectOutput {

	GetObjectInput := &s3.GetObjectInput{
		Bucket: aws.String(bucketName),
		Key:    aws.String(objectName),
	}

	payload, error := e.s3.GetObject(context.TODO(), GetObjectInput)

	if error != nil {
		fmt.Println(error)
	}

	return payload
}
