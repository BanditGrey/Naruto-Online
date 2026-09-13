package Processors.Game.Lobby.Emblem
{
   import Foundation.Crypto.TBase64;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.net.FileFilter;
   import flash.net.FileReference;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import ghostcat.fileformat.jpg.JPGEncoder;
   
   public class TProcessorWindowEmblem extends TProcessorLobbyWindow
   {
      
      protected const MaxChars:uint = 12;
      
      protected const HttpFileURI:String = "https://upload.plaync100.net/index.php";
      
      protected var FProcessorEmblem:TProcessorEmblem;
      
      protected var FMainPanel:MovieClip;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FBTN_Help:SimpleButton;
      
      protected var FBtn_Upload:MovieClip;
      
      protected var FBtn_Confirm:MovieClip;
      
      protected var FTF_Name:TextField;
      
      protected var FLoader:Loader;
      
      protected var FileRef:FileReference;
      
      protected var UrlLoader:URLLoader;
      
      public var EmblemId:int;
      
      public var OnConfirmCallback:Function;
      
      public var OnUploadCompleteHandler:Function;
      
      public var OnHelpMouseOver:Function;
      
      public var OnHelpMouseOut:Function;
      
      public function TProcessorWindowEmblem(param1:TUIComponent, param2:TProcessorEmblem)
      {
         super(param1);
         this.FProcessorEmblem = param2;
         this.FileRef = new FileReference();
         this.UrlLoader = new URLLoader();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FMainPanel = TUtilityReflection.CreateDisplayObjectInstance("EmblemPanel") as MovieClip;
         addChild(this.FMainPanel);
         this.FLoader = new Loader();
         this.FMainPanel["FEmblemBox"]["pos"].addChild(this.FLoader);
         this.FTF_Name = this.FMainPanel["TF_Name"];
         this.FTF_Name.maxChars = this.MaxChars;
         this.FBtn_Confirm = this.FMainPanel["Btn_confirm"];
         TGameUtil.setButtonMode(this.FBtn_Confirm,true);
         this.FBtn_Upload = this.FMainPanel["Btn_upload"];
         TGameUtil.setButtonMode(this.FBtn_Upload,true);
         this.FBTN_Close = this.FMainPanel["BTN_Close"];
         this.FBTN_Help = this.FMainPanel["BTN_Help"];
         this.addListener();
         this.x = FUICore.StageWidth - this.width >> 1;
         this.y = FUICore.StageHeight - this.height >> 1;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function NotificationPerform_Show() : void
      {
         if(FIsResourcesLoadCompleted)
         {
            this.CheckBtn();
         }
         super.NotificationPerform_Show();
      }
      
      protected function addListener() : void
      {
         this.FTF_Name.addEventListener(Event.CHANGE,this.OnTextInput);
         this.FBtn_Confirm.addEventListener(MouseEvent.CLICK,this.onConfirmClick);
         this.FBtn_Upload.addEventListener(MouseEvent.CLICK,this.onUploadHandle);
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.onBtnClose);
         this.FBTN_Help.addEventListener(MouseEvent.MOUSE_MOVE,this.OnButtonHelpOver);
         this.FBTN_Help.addEventListener(MouseEvent.MOUSE_OUT,this.OnButtonHelpOut);
         this.FileRef.addEventListener(Event.SELECT,this.OnSelected);
         this.FileRef.addEventListener(Event.COMPLETE,this.OnLoadComplete);
         this.FLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.CompleteHandler);
         this.UrlLoader.addEventListener(Event.COMPLETE,this.OnUploadComplete);
         this.UrlLoader.addEventListener(IOErrorEvent.IO_ERROR,this.OnErrorHandler);
      }
      
      protected function OnTextInput(param1:Event) : void
      {
         this.CheckBtn();
      }
      
      protected function onUploadHandle(param1:MouseEvent) : void
      {
         var _loc2_:FileFilter = null;
         _loc2_ = new FileFilter("Images (*.png)","*.png");
         this.FileRef.browse([_loc2_]);
      }
      
      protected function OnSelected(param1:Event) : void
      {
         this.FileRef.load();
      }
      
      protected function OnLoadComplete(param1:Event) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.target.data;
         this.FLoader.loadBytes(_loc2_);
      }
      
      protected function CompleteHandler(param1:Event) : void
      {
         this.FLoader.x = -this.FLoader.width >> 1;
         this.FLoader.y = -this.FLoader.height >> 1;
         this.CheckBtn();
      }
      
      protected function onConfirmClick(param1:MouseEvent) : void
      {
         if(this.OnConfirmCallback != null)
         {
            this.OnConfirmCallback();
         }
      }
      
      protected function OnUploadComplete(param1:Event) : void
      {
         if(this.OnUploadCompleteHandler != null)
         {
            this.OnUploadCompleteHandler(this.EmblemId,this.FTF_Name.text);
         }
         this.onBtnClose(null);
      }
      
      protected function OnErrorHandler(param1:IOErrorEvent) : void
      {
      }
      
      public function StartupLoadFile() : void
      {
         var _loc1_:BitmapData = new BitmapData(this.FLoader.width,this.FLoader.height,true,0);
         _loc1_.draw(this.FLoader);
         var _loc2_:ByteArray = new JPGEncoder().encode(_loc1_);
         var _loc3_:String = TBase64.encodeByteArray(_loc2_);
         var _loc4_:URLRequest = new URLRequest(this.HttpFileURI);
         var _loc5_:URLVariables = new URLVariables();
         _loc5_.png = _loc3_;
         _loc5_.name = this.FProcessorEmblem.UserId + "_" + this.EmblemId;
         _loc4_.data = _loc5_;
         _loc4_.method = URLRequestMethod.POST;
         this.UrlLoader.dataFormat = URLLoaderDataFormat.VARIABLES;
         this.UrlLoader.load(_loc4_);
      }
      
      protected function CheckBtn() : void
      {
         if(this.FLoader.content == null || TUtilityString.Empty(this.FTF_Name.text))
         {
            TGameUtil.setButtonMode(this.FBtn_Confirm,false);
            this.FBtn_Confirm.mouseEnabled = false;
         }
         else
         {
            TGameUtil.setButtonMode(this.FBtn_Confirm,true);
            this.FBtn_Confirm.mouseEnabled = true;
         }
      }
      
      protected function OnButtonHelpOver(param1:MouseEvent) : void
      {
         if(this.OnHelpMouseOver != null)
         {
            this.OnHelpMouseOver();
         }
      }
      
      protected function OnButtonHelpOut(param1:MouseEvent) : void
      {
         if(this.OnHelpMouseOut != null)
         {
            this.OnHelpMouseOut();
         }
      }
      
      protected function onBtnClose(param1:MouseEvent) : void
      {
         ProcessorWindowClose();
         this.dispose();
      }
      
      protected function dispose() : void
      {
         this.FLoader.unloadAndStop();
         this.FTF_Name.text = "";
      }
   }
}

