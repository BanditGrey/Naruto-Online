package Processors.Game.Lobby.Challenge.Compoents
{
   import Foundation.Common.THint;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.DatebaseVO.VO.TSkillConfig;
   import Logics.Skills.TSkill;
   import Logics.Skills.TSkills;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class THeroSkill extends TUIComponent
   {
      
      protected static const MAX_COUNT:int = 3;
      
      protected var FScene:MovieClip;
      
      protected var FSkills:TSkills;
      
      protected var FSkillsAwaken:TSkills;
      
      protected var FCurPage:int;
      
      protected var FTotlePage:int;
      
      protected var FHint:THint;
      
      protected var SkillConfig:TSkillConfig = null;
      
      protected var FSkillBins:TBins;
      
      protected var FSkillOnClick:Function;
      
      protected var FHintOnOver:Function;
      
      protected var FHintOnOut:Function;
      
      public function THeroSkill(param1:TUIComponent, param2:MovieClip)
      {
         super(param1);
         this.FScene = param2;
         addChild(this.FScene);
         this.InitSkill();
      }
      
      protected function InitSkill() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:Bitmap = null;
         this.FHint = new THint();
         TGameUtil.setButtonMode(this.FScene.btn_up,true);
         this.FScene.btn_up.addEventListener(MouseEvent.CLICK,this.OnSkillUp);
         TGameUtil.setButtonMode(this.FScene.btn_down,true);
         this.FScene.btn_down.addEventListener(MouseEvent.CLICK,this.OnSkillDown);
         _loc2_ = this.FScene.skill_cur;
         _loc3_ = new Bitmap();
         _loc2_.mc_icon.icon.addChild(_loc3_);
         _loc2_.mc_icon.icon["bitmap"] = _loc3_;
         _loc2_.addEventListener(MouseEvent.MOUSE_MOVE,this.OnCurSkillMove);
         _loc2_.addEventListener(MouseEvent.MOUSE_OUT,this.OnSkillOut);
         _loc2_.mc_over.visible = false;
         _loc2_.mc_over.mouseEnabled = false;
         _loc2_.mc_icon.mc_over.visible = false;
         _loc2_.mc_icon.mc_over.mouseEnabled = false;
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            _loc2_ = this.FScene["skill_" + _loc1_];
            _loc3_ = new Bitmap();
            _loc2_.mc_icon.icon.addChild(_loc3_);
            _loc2_.mc_icon.icon["bitmap"] = _loc3_;
            _loc2_.addEventListener(MouseEvent.MOUSE_UP,this.OnSkillSelect);
            _loc2_.addEventListener(MouseEvent.MOUSE_MOVE,this.OnSkillMove);
            _loc2_.addEventListener(MouseEvent.MOUSE_OUT,this.OnSkillOut);
            _loc2_.buttonMode = true;
            _loc2_.mc_over.visible = false;
            _loc2_.mc_icon.mc_over.visible = false;
            _loc2_.mc_over.mouseEnabled = false;
            _loc2_.mc_icon.mc_over.mouseEnabled = false;
            _loc1_++;
         }
         this.FSkillBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_SkillConfig);
      }
      
      protected function CheckBtn() : void
      {
         this.FScene.btn_up.visible = Boolean(this.FCurPage != 1);
         this.FScene.btn_down.visible = Boolean(this.FCurPage != this.FTotlePage);
      }
      
      protected function OnSkillUp(param1:MouseEvent) : void
      {
         --this.FCurPage;
         if(this.FCurPage < 1)
         {
            this.FCurPage = 1;
         }
         this.UpdataUI();
         this.CheckBtn();
      }
      
      protected function OnSkillDown(param1:MouseEvent) : void
      {
         ++this.FCurPage;
         if(this.FCurPage > this.FTotlePage)
         {
            this.FCurPage = this.FTotlePage;
         }
         this.UpdataUI();
         this.CheckBtn();
      }
      
      public function RestCurPage() : void
      {
         this.FCurPage = 1;
         if(this.FCurPage > this.FTotlePage)
         {
            this.FCurPage = this.FTotlePage;
         }
         this.CheckBtn();
      }
      
      protected function OnSkillSelect(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TSkill = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         _loc2_ += (this.FCurPage - 1) * MAX_COUNT + 1;
         _loc3_ = this.FSkills.GetSkillByIndex(_loc2_);
         if(_loc3_ != null)
         {
            if(this.FSkillOnClick != null)
            {
               this.FSkillOnClick(this,_loc3_);
            }
         }
      }
      
      protected function OnCurSkillMove(param1:MouseEvent) : void
      {
         var _loc2_:TSkill = null;
         _loc2_ = this.FSkills.GetSkillByIndex(0);
         if(param1.currentTarget.mc_over)
         {
            param1.currentTarget.mc_over.visible = true;
            param1.currentTarget.mc_icon.mc_over.visible = true;
         }
         if(_loc2_ != null)
         {
            this.FHint.Caption = _loc2_.Description;
            if(this.FHintOnOver != null)
            {
               this.FHintOnOver(this,this.FHint);
            }
         }
      }
      
      protected function OnSkillMove(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TSkill = null;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         _loc2_ += (this.FCurPage - 1) * MAX_COUNT + 1;
         _loc3_ = this.FSkills.GetSkillByIndex(_loc2_);
         if(param1.currentTarget.mc_over)
         {
            param1.currentTarget.mc_over.visible = true;
            param1.currentTarget.mc_icon.mc_over.visible = true;
         }
         if(_loc3_ != null)
         {
            this.FHint.Caption = _loc3_.Description;
            if(this.FHintOnOver != null)
            {
               this.FHintOnOver(this,this.FHint);
            }
         }
      }
      
      protected function OnSkillOut(param1:MouseEvent) : void
      {
         if(param1.currentTarget.mc_over)
         {
            param1.currentTarget.mc_over.visible = false;
            param1.currentTarget.mc_icon.mc_over.visible = false;
         }
         if(this.HintOnOut != null)
         {
            this.HintOnOut(this);
         }
      }
      
      public function get SkillOnClick() : Function
      {
         return this.FSkillOnClick;
      }
      
      public function set SkillOnClick(param1:Function) : void
      {
         this.FSkillOnClick = param1;
      }
      
      public function get HintOnOver() : Function
      {
         return this.FHintOnOver;
      }
      
      public function set HintOnOver(param1:Function) : void
      {
         this.FHintOnOver = param1;
      }
      
      public function get HintOnOut() : Function
      {
         return this.FHintOnOut;
      }
      
      public function set HintOnOut(param1:Function) : void
      {
         this.FHintOnOut = param1;
      }
      
      public function SetSkillData(param1:TSkills) : void
      {
         if(param1 == null)
         {
            return;
         }
         this.FSkills = param1;
         this.FSkills.Sort();
         if(this.FCurPage == 0)
         {
            this.FCurPage = 1;
         }
         this.FTotlePage = Math.max(int(this.FSkills.Count - 1 - 1) / MAX_COUNT + 1,1);
         this.UpdataUI();
         this.CheckBtn();
      }
      
      public function UpdataUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TSkill = null;
         var _loc4_:MovieClip = null;
         var _loc5_:TSkills = null;
         if(this.FSkills == null)
         {
            return;
         }
         _loc4_ = this.FScene.skill_cur;
         _loc3_ = this.FSkills.GetSkillByIndex(0);
         this.SkillConfig = this.FSkillBins.GetDatebaseByIdentifier(_loc3_.Identifier) as TSkillConfig;
         TGameUtil.ShowImageByID(TGameUtil.Type_SkillPic,_loc4_.mc_icon.icon["bitmap"],CONST_MODULES.MODULE_TacticalDeployment,this.SkillConfig.Icon);
         _loc4_.tf_name.text = String(_loc3_.Name);
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            _loc4_ = this.FScene["skill_" + _loc1_];
            _loc2_ = (this.FCurPage - 1) * MAX_COUNT + _loc1_ + 1;
            if(_loc2_ < this.FSkills.Count)
            {
               _loc4_.visible = true;
               _loc3_ = this.FSkills.GetSkillByIndex(_loc2_);
               _loc4_.tf_name.text = String(_loc3_.Name);
               this.SkillConfig = this.FSkillBins.GetDatebaseByIdentifier(_loc3_.Identifier) as TSkillConfig;
               TGameUtil.ShowImageByID(TGameUtil.Type_SkillPic,_loc4_.mc_icon.icon["bitmap"],CONST_MODULES.MODULE_TacticalDeployment,this.SkillConfig.Icon);
            }
            else
            {
               _loc4_.visible = false;
            }
            _loc1_++;
         }
      }
   }
}

