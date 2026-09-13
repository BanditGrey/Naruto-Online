package Processors.Game.Lobby.Talent.Component
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.Utilities.TGameUtil;
   import Logics.DatebaseVO.VO.TRoleModel;
   import Logics.SLogicsCore;
   import Logics.Talent.TNinjaTalentData;
   import Logics.Talent.TNinjaTalentVO;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUINinjaTalentBox
   {
      
      protected var MCResource:MovieClip;
      
      protected var FMC_lock:MovieClip;
      
      protected var FMC_hook:MovieClip;
      
      protected var FBTN_select:MovieClip;
      
      protected var heroBmp:Bitmap;
      
      protected var FSelected:Boolean;
      
      protected var RoleModel:TRoleModel;
      
      protected var FNinjaTalentData:TNinjaTalentData;
      
      public var NinjaTalentVO:TNinjaTalentVO;
      
      public var OnBoxSelectFun:Function;
      
      public var OnSetThisReqFun:Function;
      
      public var OnBoxLockOver:Function;
      
      public var OnBoxLockOut:Function;
      
      public var OnEffectGenerateText:Function;
      
      public var PosIdx:int;
      
      public function TUINinjaTalentBox(param1:MovieClip, param2:int = -1)
      {
         super();
         this.MCResource = param1;
         this.PosIdx = param2;
         this.heroBmp = new Bitmap();
         param1.mc_head.addChild(this.heroBmp);
         if(this.MCResource["MC_lock"])
         {
            this.FMC_lock = this.MCResource["MC_lock"];
            this.FMC_lock.visible = false;
            this.FMC_hook = this.MCResource["MC_hook"];
            this.FMC_hook.visible = false;
            this.FBTN_select = this.MCResource["BTN_select"];
            TGameUtil.setButtonMode(this.FBTN_select,true);
            this.FBTN_select.addEventListener(MouseEvent.CLICK,this.OnSelectHandler);
            this.FMC_lock.addEventListener(MouseEvent.MOUSE_MOVE,this.OnMCLockOver);
            this.FMC_lock.addEventListener(MouseEvent.MOUSE_OUT,this.OnMCLockOut);
         }
         param1.mc_head.addEventListener(MouseEvent.CLICK,this.OnSetThisHandler);
         param1.mc_head.addEventListener(MouseEvent.MOUSE_MOVE,this.OnMCLockOver);
         param1.mc_head.addEventListener(MouseEvent.MOUSE_OUT,this.OnMCLockOut);
         this.FNinjaTalentData = SLogicsCore.NinjaTalentData;
      }
      
      public function LogicsPerform() : void
      {
         if(this.RoleModel == null)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,this.heroBmp);
            return;
         }
         TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,this.heroBmp,CONST_MODULES.MODULE_NinjaTalent,this.RoleModel.RoleHead);
      }
      
      public function UpdateBox(param1:TNinjaTalentVO) : void
      {
         this.NinjaTalentVO = param1;
         this.FMC_lock.visible = param1.RefreshId == 0;
         this.RoleModel = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_RoleModel,param1.OrigionId) as TRoleModel;
      }
      
      public function UpdateHeroId(param1:int) : void
      {
         this.RoleModel = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_RoleModel,param1) as TRoleModel;
      }
      
      public function get Selected() : Boolean
      {
         return this.FSelected;
      }
      
      public function set Selected(param1:Boolean) : void
      {
         this.FSelected = param1;
         this.FMC_hook.visible = this.FSelected;
      }
      
      protected function OnSelectHandler(param1:MouseEvent) : void
      {
         if(this.FMC_lock.visible)
         {
            return;
         }
         if(this.FNinjaTalentData.RefreshStatus)
         {
            this.OnEffectGenerateText();
            return;
         }
         if(this.OnBoxSelectFun != null)
         {
            this.OnBoxSelectFun(this);
         }
      }
      
      protected function OnSetThisHandler(param1:MouseEvent) : void
      {
         if(this.FNinjaTalentData.RefreshStatus)
         {
            this.OnEffectGenerateText();
            return;
         }
         if(this.OnSetThisReqFun != null)
         {
            this.OnSetThisReqFun(this);
         }
      }
      
      protected function OnMCLockOver(param1:MouseEvent) : void
      {
         if(this.OnBoxLockOver != null)
         {
            this.OnBoxLockOver(this);
         }
      }
      
      protected function OnMCLockOut(param1:MouseEvent) : void
      {
         if(this.OnBoxLockOut != null)
         {
            this.OnBoxLockOut();
         }
      }
   }
}

