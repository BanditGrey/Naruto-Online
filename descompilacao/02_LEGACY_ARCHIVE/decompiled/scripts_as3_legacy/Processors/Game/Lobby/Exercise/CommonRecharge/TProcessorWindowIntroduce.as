package Processors.Game.Lobby.Exercise.CommonRecharge
{
   import Components.ScrollBar.TScrollBar;
   import Foundation.UI.TUIComponent;
   import Logics.Exercise.CommonRecharge.TCommonRecharge;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Exercise.CommonRecharge.Compoents.TUIActivityTab;
   import Resources.Constants.CONST_COMMONRECHARGE;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   
   public class TProcessorWindowIntroduce extends TProcessorLobbyWindow
   {
      
      protected static const MIN_SCROLL_HEIGHT:Number = 196;
      
      protected static const ITEM_STAMP:Number = 10;
      
      protected static const SINGLE_ITEM_STAMP:Number = 27;
      
      protected static const ITEM_HEIGHT:Number = 27;
      
      protected static const INIT_X:Number = 11;
      
      protected static const INIT_Y:Number = 200;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FMC_ActivityList:MovieClip;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FActivityList:Vector.<Sprite>;
      
      protected var FTF_Time:TextField;
      
      protected var FTF_Rate:TextField;
      
      protected var FMC_ActivityPic:MovieClip;
      
      protected var FBTN_Goto:SimpleButton;
      
      protected var FInitialized:Boolean;
      
      protected var FCommonRecharge:TCommonRecharge;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      public function TProcessorWindowIntroduce(param1:TUIComponent)
      {
         super(param1);
         this.FActivityList = new Vector.<Sprite>();
         this.FCommonRecharge = SLogicsCore.CommonRecharge;
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Sprite = null;
         this.FMC_Scene = param1;
         this.FMC_ActivityPic = this.FMC_Scene["MC_ActivityPic"];
         this.FBTN_Goto = this.FMC_Scene[CONST_COMMONRECHARGE.RESOURCE_Link_BTN_Goto];
         this.FBTN_Goto.addEventListener(MouseEvent.CLICK,this.ButtonOnGoto,false,0,true);
         this.FMC_ActivityList = this.FMC_Scene["MC_ActivityList"];
         this.FScrollBar = new TScrollBar(this.FMC_ActivityList.mc_list,MIN_SCROLL_HEIGHT,false,ITEM_STAMP,SINGLE_ITEM_STAMP);
         this.ResourcesPerform_UIDispatchText();
      }
      
      protected function ResourcesPerform_UIDispatchText() : void
      {
         this.FTF_Time = this.FMC_Scene.TF_Time;
         this.FTF_Rate = this.FMC_Scene.TF_Rate;
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:TUIActivityTab = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         this.FActivityList.length = 0;
         if(!this.FActivityList || this.FActivityList.length == 0)
         {
            this.FScrollBar.Clear();
            _loc3_ = int(this.FCommonRecharge.TabID.length);
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               _loc1_ = new TUIActivityTab(this);
               _loc1_.Init();
               this.FActivityList.push(_loc1_);
               this.FScrollBar.AddItem(_loc1_);
               _loc1_.SetItemInfo(_loc2_);
               _loc2_++;
            }
         }
      }
      
      protected function UpdateWindow() : void
      {
         this.FMC_ActivityPic.gotoAndStop(this.FCommonRecharge.PicID);
      }
      
      protected function ButtonOnGoto(param1:MouseEvent) : void
      {
         navigateToURL(new URLRequest(this.FCommonRecharge.GotoURL),"_about");
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = param1;
         if(this.FMC_Scene)
         {
            this.FMC_Scene.visible = param1;
         }
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.Resources_UIDispatch(param1);
         this.FInitialized = true;
      }
      
      public function UpdateUI() : void
      {
         this.UpdateText();
         this.UpdateWindow();
      }
   }
}

