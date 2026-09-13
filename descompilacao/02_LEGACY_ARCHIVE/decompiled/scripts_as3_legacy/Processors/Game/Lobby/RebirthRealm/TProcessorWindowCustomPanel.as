package Processors.Game.Lobby.RebirthRealm
{
   import Components.Pages.TUIPageOne;
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Components.TUIPet;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_MODULES;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowCustomPanel extends TProcessorLobbyWindow
   {
      
      protected static const MAX_ORGACTIVITY_COUNT:uint = 3;
      
      protected var FRootPanel:MovieClip;
      
      protected var FUIPage:TUIPageOne;
      
      protected var FPageIndex:uint = 100;
      
      protected var FRebirthRealmBaseData:TRebirthRealmBaseData = null;
      
      protected var FUintVec:Vector.<MovieClip> = null;
      
      protected var FPet:Vector.<TUIPet>;
      
      public var WaitReq:Boolean;
      
      protected var FChanllge_Btn:Function;
      
      public function TProcessorWindowCustomPanel(param1:TUIComponent, param2:TRebirthRealmBaseData)
      {
         super(param1);
         this.FRebirthRealmBaseData = param2;
         this.FPet = new Vector.<TUIPet>(MAX_ORGACTIVITY_COUNT);
         this.FUintVec = new Vector.<MovieClip>(MAX_ORGACTIVITY_COUNT);
         this.WaitReq = false;
      }
      
      public function SetThisPanel(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TUIPet = null;
         this.FRootPanel = param1;
         this.FUIPage = new TUIPageOne(FParent);
         this.FUIPage.ButtonPrevious.Substrate = this.FRootPanel["BTN_Left"];
         this.FUIPage.ButtonNext.Substrate = this.FRootPanel["BTN_Right"];
         this.FUIPage.PageSize = MAX_ORGACTIVITY_COUNT;
         this.FUIPage.Init();
         this.FUIPage.OnChangePage = this.PageOnChange;
         _loc2_ = 0;
         while(_loc2_ < MAX_ORGACTIVITY_COUNT)
         {
            this.FUintVec[_loc2_] = this.FRootPanel["MC_Hero_" + _loc2_];
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < MAX_ORGACTIVITY_COUNT)
         {
            _loc3_ = new TUIPet(this);
            MovieClip(this.FUintVec[_loc2_]["MC_Hero"]).addChild(_loc3_);
            TGameUtil.setButtonMode(this.FUintVec[_loc2_]["BTN_Recruit"],true);
            MovieClip(this.FUintVec[_loc2_]["BTN_Recruit"]).addEventListener(MouseEvent.CLICK,this.ChanllgeClick);
            _loc3_.OnQuerySequenceContext = this.ShowImage;
            _loc3_.DefaultRole = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_DefaultRoleTexture) as Sprite;
            this.FPet[_loc2_] = _loc3_;
            _loc2_++;
         }
      }
      
      public function UpdatePerform() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < MAX_ORGACTIVITY_COUNT)
         {
            this.FPet[_loc1_].Update();
            _loc1_++;
         }
      }
      
      public function ClosePanel() : void
      {
      }
      
      public function ShowImage(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:TBounds = null;
         var _loc6_:TCoordinate = null;
         var _loc7_:TResourceRepositoryTexture = null;
         var _loc8_:TTexture = null;
         _loc7_ = SResourcesCore.TexturesModel;
         var _loc9_:TUIPet = param1 as TUIPet;
         var _loc10_:int = param2 as int;
         _loc5_ = new TBounds();
         _loc6_ = new TCoordinate();
         _loc8_ = _loc7_.GetTextureByIdentifier(_loc10_);
         if(_loc8_ != null)
         {
            param3.Value = _loc8_.GetAnimationSequenceByIndex(0);
            param3.Value.Evaluate(_loc6_,_loc5_);
            _loc9_.X = _loc5_.X;
            _loc9_.Y = _loc5_.Y;
         }
         else
         {
            _loc7_.LoadSecondary(_loc10_,CONST_MODULES.MODULE_RebirthRealm);
            _loc9_.X = 0;
            _loc9_.Y = 0;
         }
      }
      
      public function UpdateManual() : void
      {
         var _loc1_:int = 0;
         if(this.FRebirthRealmBaseData.NextCustomLittle == 0)
         {
            _loc1_ = 7;
         }
         else if(this.FRebirthRealmBaseData.NextCustomLittle >= 8)
         {
            _loc1_ = 7;
         }
         else
         {
            _loc1_ = this.FRebirthRealmBaseData.NextCustomLittle - 1;
         }
         this.FUIPage.TotalQuantity = this.FRebirthRealmBaseData.CustomImageVec.length;
         this.FUIPage.PageIndex = _loc1_;
         this.FUIPage.Update();
         this.UpdateForS_C(_loc1_);
      }
      
      protected function PageOnChange(param1:Object, param2:int) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         if(param2 == this.FPageIndex)
         {
            return;
         }
         this.FPageIndex = param2;
         this.ImageChange();
         this.IsShowChanllegBtn();
      }
      
      public function UpdateForS_C(param1:int) : void
      {
         this.FPageIndex = param1;
         this.ImageChange();
         this.IsShowChanllegBtn();
      }
      
      public function ImageChange() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < MAX_ORGACTIVITY_COUNT)
         {
            this.FPet[_loc1_].Context = this.FRebirthRealmBaseData.CustomImageVec[this.FPageIndex + _loc1_];
            TextField(this.FUintVec[_loc1_]["TF_Name"]).text = this.FRebirthRealmBaseData.CustomImageName[this.FPageIndex + _loc1_];
            _loc1_++;
         }
      }
      
      public function IsShowChanllegBtn() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < MAX_ORGACTIVITY_COUNT)
         {
            MovieClip(this.FUintVec[_loc1_]["BTN_Recruit"]).visible = false;
            MovieClip(this.FUintVec[_loc1_]["mc_pass"]).visible = false;
            if(this.FRebirthRealmBaseData.NextCustomLittle == 0)
            {
               MovieClip(this.FUintVec[_loc1_]["mc_pass"]).visible = true;
            }
            else if(this.FRebirthRealmBaseData.NextCustomLittle == this.FPageIndex + _loc1_ + 1)
            {
               MovieClip(this.FUintVec[_loc1_]["BTN_Recruit"]).visible = true;
            }
            else if(this.FRebirthRealmBaseData.NextCustomLittle > this.FPageIndex + _loc1_ + 1)
            {
               MovieClip(this.FUintVec[_loc1_]["mc_pass"]).visible = true;
            }
            MovieClip(this.FUintVec[_loc1_]["MC_BackGround"]).gotoAndStop(this.FRebirthRealmBaseData.todayChallengeType);
            _loc1_++;
         }
      }
      
      public function set Chanllge_Btn(param1:Function) : void
      {
         this.FChanllge_Btn = param1;
      }
      
      public function ChanllgeClick(param1:MouseEvent) : void
      {
         if(this.FChanllge_Btn != null && !this.WaitReq)
         {
            this.WaitReq = true;
            this.FChanllge_Btn();
         }
      }
   }
}

