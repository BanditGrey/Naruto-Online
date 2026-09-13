package Processors.Game.Lobby.OhtsutsukiKaguya.CellMc
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.TNightPowerConfig;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_OhtsutsukiKaguya;
   import Resources.Strings.STRING_OhtsutsukiKaguya;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class TPSpriStripTwo extends Sprite
   {
      
      protected var ThisPanel:MovieClip = null;
      
      protected var This_Middle_Panmel:MovieClip = null;
      
      protected var Fupgrade_notice:TextField = null;
      
      protected var Fprivilege_giftbag:TextField = null;
      
      protected var Ffunction_privilege:TextField = null;
      
      protected var FTF_Level:TextField = null;
      
      protected var FCurDate:TNightPowerConfig;
      
      public function TPSpriStripTwo()
      {
         super();
         this.LoadPrimary();
         this.LoadFla();
      }
      
      protected function LoadPrimary() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_OhtsutsukiKaguya.This_Resource_Id);
      }
      
      protected function LoadFla() : void
      {
         this.ThisPanel = TUtilityReflection.CreateDisplayObjectInstance(CONST_OhtsutsukiKaguya.This_panel_Mc_MC_middle_fream) as MovieClip;
         this.addChild(this.ThisPanel);
         this.Initilization();
      }
      
      public function set CurDate(param1:TNightPowerConfig) : void
      {
         this.FCurDate = param1;
         this.UpdateView();
      }
      
      protected function Initilization() : void
      {
         this.This_Middle_Panmel = this.ThisPanel["middle_fream"];
         this.FTF_Level = this.This_Middle_Panmel["TF_Level"];
         this.Fupgrade_notice = this.This_Middle_Panmel["upgrade_notice"];
         this.Fprivilege_giftbag = this.This_Middle_Panmel["privilege_giftbag"];
         this.Ffunction_privilege = this.This_Middle_Panmel["function_privilege"];
      }
      
      public function UpdateView() : void
      {
         var _loc1_:RegExp = /%%/g;
         var _loc2_:String = "";
         this.FTF_Level.text = TUtilityString.Format(STRING_OhtsutsukiKaguya.Middle_level,this.FCurDate.Level);
         _loc2_ = this.FCurDate.DesLevelup;
         _loc2_ = _loc2_.replace(_loc1_,"\n");
         this.Fupgrade_notice.text = _loc2_;
         _loc2_ = this.FCurDate.DesPrivilege.replace(_loc1_,"\n");
         this.Ffunction_privilege.text = _loc2_;
         _loc2_ = this.FCurDate.DesReward.replace(_loc1_,"\n");
         this.Fprivilege_giftbag.text = TUtilityString.Format(STRING_OhtsutsukiKaguya.Middle_privilege_level,_loc2_);
      }
      
      protected function GetDec() : String
      {
         var _loc1_:TArticle = null;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,this.FCurDate.DailyReward) as TArticle;
         return _loc1_.FunctionDesc;
      }
      
      protected function ss() : void
      {
      }
   }
}

