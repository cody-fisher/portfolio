import React from "react";
import { Container, Row, Col, Card, Button } from "react-bootstrap";
import projectOneImage from '../assets/project1.jpg'
import projectTwoImage from '../assets/project2.jpg'
import projectThreeImage from '../assets/project3.jpg'

const Portfolio: React.FC = () => {
  return (
    <Container>
      <Row className="mt-5">
        <Col md={4}>
          <Card>
            <Card.Img variant="top" src={projectOneImage} style={{ width: '150px', height: '200px' }} />
            <Card.Body>
              <Card.Title>Project 1</Card.Title>
              <Card.Text>
                Golang Project
              </Card.Text>
              <Button variant="primary">Learn More</Button>
            </Card.Body>
          </Card>
        </Col>
        <Col md={4}>
          <Card>
            <Card.Img variant="top" src={projectTwoImage} style={{ width: '200px', height: '200px' }} />
            <Card.Body>
              <Card.Title>Project 2</Card.Title>
              <Card.Text>
                Python Project
              </Card.Text>
              <Button variant="primary">Learn More</Button>
            </Card.Body>
          </Card>
        </Col>
        <Col md={4}>
          <Card>
            <Card.Img variant="top" src={projectThreeImage} style={{ width: '200px', height: '200px' }} />
            <Card.Body>
              <Card.Title>Project 3</Card.Title>
              <Card.Text>
                React Project
              </Card.Text>
              <Button variant="primary">Learn More</Button>
            </Card.Body>
          </Card>
        </Col>
      </Row>
    </Container>
  );
};

export default Portfolio;
