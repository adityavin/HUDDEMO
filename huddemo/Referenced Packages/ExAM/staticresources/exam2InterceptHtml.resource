<html><head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"><style>
  .exam-modal:before {
    content: '';
    display: none;
    background: rgba(0, 0, 0, 0.6);
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    z-index: 10;
  }
  .exam-modal:target:before {
    display: block;
  }
  .exam-modal:target .modal-dialog {
    -webkit-transform: translate(0, 0);
    -ms-transform: translate(0, 0);
    transform: translate(0, 0);
    top: 5%;
  }
  .modal-dialog {
    background: #fefefe;
    border: #333 solid 1px;
    border-radius: 5px;
    margin-left: -200px;
    position: fixed;
    left: 50%;
    top: -100%;
    z-index: 11;
    width: 645px;
    -webkit-transform: translate(0, -500%);
    -ms-transform: translate(0, -500%);
    transform: translate(0, -500%);
    -webkit-transition: -webkit-transform 0.3s ease-out;
    -moz-transition: -moz-transform 0.3s ease-out;
    -o-transition: -o-transform 0.3s ease-out;
    transition: transform 0.3s ease-out;
  }
  .modal-body {
    padding: 20px;
  }
  .modal-header,
  .modal-footer {
    padding: 10px 20px;
  }
  .modal-header {
    border-bottom: #eee solid 1px;
  }
  .modal-header h2 {
    font-size: 20px;
    display: inline-block;
  }
  .modal-header .btn-close {
    float:right;
  }
  .modal-footer {
    border-top: #eee solid 1px;
    text-align: right;
  }
  iframe{
    width: 600px;
    height: 490px;
  }
  /*ADDED TO STOP SCROLLING TO TOP*/
  #close {
    display: none;
  }
</style>
</head><body><div class="exam-modal" id="exam-modal" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-header">
      <h2>ExAM Survey</h2>
      <a href="#close" class="btn-close" aria-hidden="true">×</a> <!--CHANGED TO "#close"-->
    </div>
    <div class="modal-body">
      <iframe src="{{clientURL}}"></iframe>
    </div>
    <div class="modal-footer">
      <a href="#close" class="btn">Close</a>
    </div>
    </div>
  </div>

</body></html>