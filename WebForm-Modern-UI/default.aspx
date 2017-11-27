﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="WebForm_Modern_UI._default" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>GroupDocs.Viewer for .NET (Web Forms)</title>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/angular_material/1.1.0/angular-material.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons|Roboto+Condensed:400,700">
    <link href="/Content/style.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.1/angular.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.1/angular-animate.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.1/angular-aria.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.1/angular-resource.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angular_material/1.1.0/angular-material.min.js"></script>
    <script src="/Content/custom.js"></script>
    <script>

        // For complete documentation, please visit: https://docs.groupdocs.com/display/viewernet/GroupDocs.Viewer+for+.NET+-+MVC+Modern+UI
        // Custom.js should be called before this JS parameter configurationns.

        ///// ********************************* //////
        ///// DYNAMIC CONFIGURATIONS JS PARAMETERS
        ///// By Default all properties are set to visible all tools.
        ///// ********************************* //////

        // Un-comment to Show/Hide Toolbar Controls
        //ShowWatermark = false;
        //ShowImageToggle = false;
        //ShowDownloads = false;
        //ShowFileSelection = false;
        //ShowThubmnailPanel = false;
        EnableContextMenu = true;

        // Set Default values
        DefaultFilePath = 'calibre.docx'; // leave empty to skip default file loading, defined file name should be available in application 'App_Data' folder.
        isImageToggle = false; // set true to display image mode rendering by default.
        RotateAngel = 0; // integer value e.g 0 or 90 or 180 or 270.

        // Set Watermark properties
        WatermarkText = "my watermark text";
        WatermarkColor = 4366342; // integer values represents the ARGB color.
        WatermarkPosition = 'Diagonal'; // e.g Diagonal, TopLeft, TopCenter, TopRight, BottomLeft, BottomCenter, BottomRight, 
        WatermarkWidth = 70.0; // float values.
        WatermarkOpacity = 180; // integer values.
  </script>
    <script src="/Content/app.js"></script>
</head>
<body oncontextmenu="if (!EnableContextMenu) return false;">

    <div ng-app="GroupDocsViewer" ng-cloak flex layout="column" style="height: 100%;">
        <md-toolbar ng-controller="ToolbarController" layout="row" hide-print md-whiteframe="4" class="md-toolbar-tools md-scroll-shrink">
      <md-button class="md-icon-button" ng-click="toggleLeft()" ng-hide="ShowHideTools.IsThubmnailPanel">
        <md-icon>menu</md-icon>
      </md-button>
      <a href="/"><img src="/Content/GDVLogo.png" /></a>&nbsp; <a href="/"><h1>Viewer for .NET (Web Forms)</h1></a>
      <span flex></span>
      <md-switch ng-change="onSwitchChange(data.toggleView)" ng-model="data.toggleView" aria-label="HTML View" ng-hide="ShowHideTools.IsShowImageToggle" ng-true-value="'Image View'" ng-false-value="'HTML View'">
        {{ data.toggleView }}
        <md-tooltip>Toggle <span ng-hide="isImage">Image</span><span ng-hide="!isImage">HTML</span> View</md-tooltip>
      </md-switch>
      <md-button ng-click="rotateDocument()" class="md-icon-button" ng-disabled="!isImage" ng-hide="ShowHideTools.IsShowRotateImage">
        <md-icon>rotate_left</md-icon>
        <md-tooltip>Rotate</md-tooltip>
      </md-button>

      <md-button ng-click="previousDocument()" class="md-icon-button" ng-disabled="!selectedFile" ng-hide="ShowHideTools.IsFileSelection">
        <md-icon>navigate_before</md-icon>
        <md-tooltip>Previous Document</md-tooltip>
      </md-button>
      <div ng-controller="AvailableFilesController">
        <md-select style="overflow:hidden; width:150px!important;" ng-model="selectedFile" placeholder="Please select a file" md-on-open="onOpen()" ng-hide="ShowHideTools.IsFileSelection">
          <md-optgroup label="Available files">
            <md-option ng-value="item" ng-click="onChange(item)" ng-repeat="item in list">{{ item }}</md-option>
          </md-optgroup>
        </md-select>
      </div>
      <md-button ng-click="nextDocument()" class="md-icon-button" ng-disabled="!selectedFile" ng-hide="ShowHideTools.IsFileSelection">
        <md-icon>navigate_next</md-icon>
        <md-tooltip>Next Document</md-tooltip>
      </md-button>
      <md-menu ng-hide="ShowHideTools.IsShowDownloads">
        <md-button class="md-icon-button" ng-click="this.openMenu($mdOpenMenu, $event)">
          <md-icon>file_download</md-icon>
          <md-tooltip>Download Document</md-tooltip>
        </md-button>
        <md-menu-content width="4">
          <md-menu-item ng-hide="ShowHideTools.IsShowDownloads">
            <md-button ng-href="/downloadpdf?file={{ selectedFile }}&watermarkText={{Watermark.Text}}&watermarkColor={{Watermark.Color}}&watermarkPosition={{Watermark.Position}}&watermarkWidth={{Watermark.Width}}&watermarkOpacity={{Watermark.Opacity}}&isdownload=false"
            target="_blank" ng-disabled="!selectedFile">
              <md-icon md-menu-origin md-menu-align-target>picture_as_pdf</md-icon>
              Open as PDF
            </md-button>
          </md-menu-item>
          <md-menu-item ng-hide="ShowHideTools.IsShowDownloads">
            <md-button ng-href="/downloadpdf?file={{ selectedFile }}&watermarkText={{Watermark.Text}}&watermarkColor={{Watermark.Color}}&watermarkPosition={{Watermark.Position}}&watermarkWidth={{Watermark.Width}}&watermarkOpacity={{Watermark.Opacity}}&isdownload=true"
            target="_blank" ng-disabled="!selectedFile">
              <md-icon md-menu-origin md-menu-align-target>picture_as_pdf</md-icon>
              Download as PDF
            </md-button>
          </md-menu-item>
          <md-menu-item ng-hide="ShowHideTools.IsShowDownloads">
            <md-button ng-href="/downloadoriginal?file={{ selectedFile }}" ng-disabled="!selectedFile">
              <md-icon md-menu-origin md-menu-align-target>file_download</md-icon>
              Download Original
            </md-button>

          </md-menu-item>
        </md-menu-content>
      </md-menu>
      <md-button class="md-icon-button">
        <md-icon>more_vert</md-icon>
      </md-button>
    </md-toolbar>
        <md-content flex layout="row" md-scroll-y>
      <md-content flex id="content" class="md-padding" role="main">
        <div ng-controller="PagesController">
          <md-card card-set-dimensions ng-repeat="item in docInfo.pages">
            <a name="page-view-{{ item.number }}"></a>
            <iframe iframe-set-dimensions-onload align="middle" ng-src="{{ createPageUrl(selectedFile, item.number) }}" allowTransparency="true"></iframe>
          </md-card>
          <div ng-repeat="attachment in docInfo.attachments">
            <md-card ng-repeat="number in attachment.count">
              <a name="page-view-{{attachment.name}}-{{number}}"></a>
              <iframe ng-src="{{ createAttachmentPageUrl(selectedFile,attachment.name,number) }}" frameborder="0" allowTransparency="true"></iframe>
            </md-card>
          </div>

        </div>
      </md-content>
      <md-sidenav md-component-id="left" hide-print md-whiteframe="4" class="md-sidenav-left">
        <md-tabs md-dynamic-height md-border-bottom>
          <md-tab label="Thumbnails">
            <md-content role="navigation">
              <div ng-controller="ThumbnailsController">
                <md-card ng-repeat="item in docInfo.pages" class="thumbnail">
                  <img name="imghumb-{{ item.number }}" ng-class="{selectedthumbnail: item === selected}" ng-src="{{ createThumbnailUrl(selectedFile, item.number) }}" ng-click="onThumbnailClick($event, item)" class="md-card-image page-thumbnail" />
                </md-card>
                <div ng-repeat="attachment in docInfo.attachments">
                  <md-card ng-repeat="number in  attachment.count">
                    <img ng-src="{{  createAttachmentThumbnailPageUrl(selectedFile,attachment.name,number) }}" ng-click="onAttachmentThumbnailClick($event,attachment.name,number)" class="md-card-image page-thumbnail" />
                  </md-card>
                </div>
              </div>
            </md-content>
          </md-tab>
        </md-tabs>
      </md-sidenav>
    </md-content>
    </div>
</body>
</html>


