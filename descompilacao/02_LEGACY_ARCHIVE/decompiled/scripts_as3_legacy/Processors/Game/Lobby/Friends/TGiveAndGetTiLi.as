package Processors.Game.Lobby.Friends
{
   import Components.Pages.TUIPage;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TFriendDigestTiLi;
   import Logics.Characters.TFriendDigests;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Friends.Components.TUITemTiLi;
   import Resources.Constants.CONST_FRIEND;
   import Resources.Strings.STRING_FRIEND;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TGiveAndGetTiLi extends TProcessorLobbyWindow
   {
      
      public static const eleven:int = 11;
      
      protected var FThisPanel:Sprite;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FBTN_OneKeyGet:MovieClip;
      
      protected var FTF_GetCountDec:TextField;
      
      protected var FItemTiLiVec:Vector.<TUITemTiLi>;
      
      protected var FPropPage:TUIPage = null;
      
      protected var FPropPageIndex:int;
      
      protected var FPropTabIndex:int;
      
      protected var FFriendDate:TFriendDigests;
      
      protected var FGetBtnBack:Function;
      
      protected var FOneKeyGetFun:Function;
      
      public function TGiveAndGetTiLi(param1:TUIComponent)
      {
         super(param1);
         this.graphics.beginFill(0,0.3);
         this.graphics.drawRect(-(FUICore.StageWidth / 2),-(FUICore.StageHeight / 2),FUICore.StageWidth * 2,FUICore.StageHeight * 2);
         this.graphics.endFill();
         this.FPropPage = new TUIPage(this);
         this.FPropPageIndex = 0;
         this.FPropTabIndex = 0;
         this.FItemTiLiVec = new Vector.<TUITemTiLi>(eleven);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_FRIEND.RESOURCESID_Swf_Friend);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:TUITemTiLi = null;
         var _loc2_:int = 0;
         this.FThisPanel = TUtilityReflection.CreateDisplayObjectInstance("MC_GetTiLi") as Sprite;
         addChild(this.FThisPanel);
         this.FThisPanel.x = (FUICore.StageWidth - this.FThisPanel.width) / 2;
         this.FThisPanel.y = (FUICore.StageHeight - this.FThisPanel.height) / 2;
         this.FBTN_Close = this.FThisPanel["BTN_Close"];
         this.FBTN_OneKeyGet = this.FThisPanel["BTN_OneKeyGet"];
         this.FTF_GetCountDec = this.FThisPanel["TF_GetCountDec"];
         this.FPropPage.ButtonPrevious.Substrate = this.FThisPanel["MC_Page"]["MC_PageLeft"];
         this.FPropPage.ButtonNext.Substrate = this.FThisPanel["MC_Page"]["MC_PageRight"];
         this.FPropPage.LabelPage = this.FThisPanel["MC_Page"]["TF_Text"];
         TextField(this.FThisPanel["MC_Page"]["TF_Text"]).text = "0/0";
         this.FPropPage.PageSize = eleven;
         this.FPropPage.Init();
         this.FPropPage.OnChangePage = this.PageOnChange;
         _loc2_ = 0;
         while(_loc2_ < eleven)
         {
            _loc1_ = new TUITemTiLi();
            _loc1_.ThisPanel = this.FThisPanel["MC_FightingRank_" + _loc2_];
            _loc1_.BackFun = this.TiLiBackFun;
            this.FItemTiLiVec[_loc2_] = _loc1_;
            _loc2_++;
         }
         super.ResourcesPerform_UIDispatch();
      }
      
      public function UpdateneKeyGetState() : void
      {
         if(this.FFriendDate.OneKeyGetIsCanClcik())
         {
            TGameUtil.setButtonMode(this.FBTN_OneKeyGet,true);
         }
         else
         {
            TGameUtil.setButtonMode(this.FBTN_OneKeyGet,false);
         }
      }
      
      public function UpdatePage() : void
      {
         this.FPropPage.TotalQuantity = this.FFriendDate.GetCountByType(1);
         this.FPropPage.PageIndex = this.FPropTabIndex;
         this.FPropPage.Update();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.ClickHandle);
         this.FBTN_OneKeyGet.addEventListener(MouseEvent.CLICK,this.ClickHandle);
         super.ResourcesPerform_UILocations();
      }
      
      protected function ClickHandle(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FBTN_Close:
               this.visible = false;
               break;
            case this.FBTN_OneKeyGet:
               if(!this.FBTN_OneKeyGet.buttonMode)
               {
                  return;
               }
               if(this.FOneKeyGetFun != null)
               {
                  this.FOneKeyGetFun();
               }
         }
      }
      
      public function set OneKeyGetFun(param1:Function) : void
      {
         this.FOneKeyGetFun = param1;
      }
      
      protected function TiLiBackFun(param1:TFriendDigestTiLi) : void
      {
         if(this.FGetBtnBack != null)
         {
            this.FGetBtnBack(param1);
         }
      }
      
      protected function PageOnChange(param1:Object, param2:int) : void
      {
         this.FPropPageIndex = param2;
         this.FPropTabIndex = 0;
         this.FPropTabIndex += this.FPropPageIndex * eleven;
         this.UpdateView();
      }
      
      public function UpdateView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(!this.FItemTiLiVec[0])
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < eleven)
         {
            _loc2_ = this.FPropTabIndex * eleven + _loc1_;
            if(_loc2_ >= this.FFriendDate.GetVecByType(1).length)
            {
               this.FItemTiLiVec[_loc1_].ThisPanel.visible = false;
            }
            else
            {
               this.FItemTiLiVec[_loc1_].ThisPanel.visible = true;
               this.FItemTiLiVec[_loc1_].SetDate = this.FFriendDate.GetVecByType(1)[_loc2_];
            }
            _loc1_++;
         }
         this.UpdatePage();
         this.UpdateneKeyGetState();
         this.UpdateYiYongCount();
      }
      
      public function UpdateGetBtnState() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < eleven)
         {
            if(this.FItemTiLiVec[_loc1_].ThisPanel.visible)
            {
               this.FItemTiLiVec[_loc1_].UpdateView();
            }
            _loc1_++;
         }
         this.UpdateneKeyGetState();
      }
      
      public function UpdateYiYongCount() : void
      {
         this.FTF_GetCountDec.text = TUtilityString.Format(STRING_FRIEND.STRING_CountDec,this.FFriendDate.GetLingQuCount(),this.FFriendDate.GetCountMax);
      }
      
      public function set AllData(param1:TFriendDigests) : void
      {
         this.FFriendDate = param1;
      }
      
      public function set GetBtnBack(param1:Function) : void
      {
         this.FGetBtnBack = param1;
      }
   }
}

