import React, {Component} from 'react';
import Modal from "react-bulma-components/lib/components/modal";

class ShowDetailModal extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    let {text, title, ...props} = this.props;
    return <Modal {...props}>
      <Modal.Card>
        <Modal.Card.Head onClose={props.onClose}>
          <Modal.Card.Title>{title}</Modal.Card.Title>
        </Modal.Card.Head>
        <Modal.Card.Body>
          <pre>{text}</pre>
        </Modal.Card.Body>
      </Modal.Card>
    </Modal>
  }
}

export default ShowDetailModal;