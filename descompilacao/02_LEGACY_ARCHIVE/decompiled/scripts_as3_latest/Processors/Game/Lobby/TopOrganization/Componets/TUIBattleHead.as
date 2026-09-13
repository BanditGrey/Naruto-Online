package Processors.Game.Lobby.TopOrganization.Componets
{
   import Foundation.UI.TUIComponent;
   import Logics.SLogicsCore;
   import Logics.TopOrganization.TOrgMemberDigest;
   import Processors.Game.Lobby.Common.TProcessorUIResourceTemplate;
   import Resources.Constants.CONST_TOPORGANIZATION;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class TUIBattleHead extends TProcessorUIResourceTemplate
   {
      
      protected var FTF_Name:TextField;
      
      protected var FMC_HpBar:MovieClip;
      
      protected var FMC_HeroHead:MovieClip;
      
      protected var FTF_Level:TextField;
      
      protected var FPlayerModel:MovieClip;
      
      protected var FHPBarMask:MovieClip;
      
      protected var FMC_LeadLine:Sprite;
      
      protected var FSpeed:int;
      
      protected var FStartPositionX:Number;
      
      protected var FHPBarWidth:Number;
      
      protected var FStatus:uint;
      
      protected var FType:uint;
      
      protected var FHPBarStartPositionX:Number;
      
      protected var FOnPlayeBoomEffect:Function;
      
      protected var FIsFirstSet:Boolean;
      
      public function TUIBattleHead(param1:TUIComponent)
      {
         super(param1);
         this.FStatus = 0;
         this.FSpeed = 4;
      }
      
      override protected function UIDispatch() : void
      {
         this.FTF_Name = FResource["TF_Name"];
         this.FTF_Level = FResource["TF_Level"];
         this.FMC_HpBar = FResource["MC_HpBar"];
         this.FHPBarMask = this.FMC_HpBar["MC_Mask"];
         this.FMC_HeroHead = FResource["MC_HeroHead"];
         this.FMC_LeadLine = FResource["MC_LeadLine"];
         this.FHPBarWidth = this.FHPBarMask.width;
         this.FHPBarStartPositionX = this.FHPBarMask.x;
         this.FStartPositionX = this.FMC_HeroHead.x;
      }
      
      override protected function UILocations() : void
      {
         super.UILocations();
      }
      
      override protected function UpdateUI() : void
      {
         var _loc1_:TOrgMemberDigest = null;
         if(FContext == null)
         {
            this.Reset();
            return;
         }
         _loc1_ = FContext as TOrgMemberDigest;
         this.FTF_Name.text = _loc1_.Name;
         this.FTF_Level.text = SLogicsCore.Character.MainHero.GetLevelStrByLevel(_loc1_.Level);
         this.FMC_HeroHead.visible = true;
         this.FMC_HeroHead.gotoAndStop("ID" + _loc1_.TemplateID);
         this.FPlayerModel = this.FMC_HeroHead["MC_PlayerModel"];
         this.FPlayerModel.gotoAndStop(1);
         this.FMC_HpBar.visible = true;
         if(_loc1_.LeftHP != 0)
         {
            if(this.FType == CONST_TOPORGANIZATION.TYPE_LeftOrg)
            {
               this.FHPBarMask.x += (1 - _loc1_.LeftHP / 100) * this.FHPBarWidth;
            }
            else if(this.FType == CONST_TOPORGANIZATION.TYPE_RightOrg)
            {
               this.FHPBarMask.width = this.FHPBarWidth * _loc1_.LeftHP / 100;
            }
         }
      }
      
      public function set OnPlayeBoomEffect(param1:Function) : void
      {
         this.FOnPlayeBoomEffect = param1;
      }
      
      public function get Type() : uint
      {
         return this.FType;
      }
      
      public function set Type(param1:uint) : void
      {
         this.FType = param1;
      }
      
      public function get Status() : uint
      {
         return this.FStatus;
      }
      
      public function set Status(param1:uint) : void
      {
         this.FStatus = param1;
      }
      
      public function get IsFirstSet() : Boolean
      {
         return this.FIsFirstSet;
      }
      
      public function set IsFirstSet(param1:Boolean) : void
      {
         this.FIsFirstSet = param1;
      }
      
      public function StopWait() : void
      {
         this.FPlayerModel.gotoAndStop(9);
      }
      
      public function PlayWaitAnimation() : void
      {
         this.FPlayerModel.play();
         if(this.FPlayerModel.currentFrame == 8)
         {
            this.FPlayerModel.gotoAndPlay(1);
         }
      }
      
      public function PlayMoveAnimation() : void
      {
         this.FPlayerModel.play();
         if(this.FPlayerModel.currentFrame == this.FPlayerModel.totalFrames)
         {
            this.FPlayerModel.gotoAndPlay(9);
         }
         if(this.FType == CONST_TOPORGANIZATION.TYPE_LeftOrg)
         {
            this.FMC_HeroHead.x += this.FSpeed;
            if(this.FMC_HeroHead.x >= this.FMC_LeadLine.x + this.FMC_LeadLine.width)
            {
               this.FStatus = CONST_TOPORGANIZATION.STATUS_Fight;
            }
         }
         else if(this.FType == CONST_TOPORGANIZATION.TYPE_RightOrg)
         {
            this.FMC_HeroHead.x += -this.FSpeed;
            if(this.FMC_HeroHead.x <= this.FMC_LeadLine.x - this.FMC_HeroHead.width + this.FStartPositionX)
            {
               this.FStatus = CONST_TOPORGANIZATION.STATUS_Fight;
            }
         }
      }
      
      override public function Reset() : void
      {
         super.Reset();
         this.FMC_HeroHead.x = this.FStartPositionX;
         this.FStatus = 0;
         this.FHPBarMask.x = this.FHPBarStartPositionX;
         this.FHPBarMask.width = this.FHPBarWidth;
         this.FMC_HeroHead.visible = false;
         this.FMC_HpBar.visible = false;
         if(this.FPlayerModel != null)
         {
            this.FPlayerModel.gotoAndStop(1);
         }
      }
   }
}

