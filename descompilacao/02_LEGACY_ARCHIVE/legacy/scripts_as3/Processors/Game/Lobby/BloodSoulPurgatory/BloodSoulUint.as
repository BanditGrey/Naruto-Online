package Processors.Game.Lobby.BloodSoulPurgatory
{
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TBloodSoul_Attr;
   import Resources.Constants.CONST_BLOODPURGATORY;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_COMMON;
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public class BloodSoulUint
   {
      
      protected var FBloodSoulPanel:MovieClip;
      
      protected var FLevel:TextField;
      
      protected var FTF_SoulExp:TextField;
      
      protected var FMC_Blood_Bar:MovieClip;
      
      protected var FTF_Cur_Blood:TextField;
      
      protected var FTF_Next_Blood:TextField;
      
      protected var FMC_BloodBackGround:MovieClip;
      
      protected var FStuffId:int;
      
      protected var FGlodTimers:int;
      
      protected var FIsOpen:Boolean;
      
      protected var FJudge:int;
      
      public function BloodSoulUint(param1:MovieClip, param2:int)
      {
         super();
         this.FBloodSoulPanel = param1;
         this.FLevel = this.FBloodSoulPanel[CONST_BLOODPURGATORY.BooldPurgatory_TF_SoulLevel];
         this.FTF_SoulExp = this.FBloodSoulPanel[CONST_BLOODPURGATORY.BooldPurgatory_TF_SoulExp];
         this.FTF_SoulExp.multiline = true;
         this.FMC_Blood_Bar = this.FBloodSoulPanel[CONST_BLOODPURGATORY.BooldPurgatory_MC_Blood_Bar];
         if(this.FMC_Blood_Bar)
         {
            this.FMC_Blood_Bar.gotoAndStop(param2 + 1);
         }
         this.FMC_BloodBackGround = this.FBloodSoulPanel[CONST_BLOODPURGATORY.BooldPurgatory_MC_BloodBackGround];
         this.FMC_BloodBackGround.gotoAndStop(param2 + 1);
         this.FTF_Cur_Blood = this.FBloodSoulPanel[CONST_BLOODPURGATORY.BooldPurgatory_TF_Cur_Blood];
         this.FTF_Next_Blood = this.FBloodSoulPanel[CONST_BLOODPURGATORY.BooldPurgatory_TF_Next_Blood];
      }
      
      public function initili(param1:DataStructureForBloodSoul) : void
      {
         var _loc2_:int = 0;
         var _loc5_:TBloodSoul_Attr = null;
         this.FGlodTimers = param1.goldTimes;
         var _loc3_:int = param1.SoulId;
         var _loc4_:int = param1.CurExp;
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BloodPurgatory_Attr,_loc3_) as TBloodSoul_Attr;
         if(!_loc5_)
         {
            this.FLevel.text = "";
            return;
         }
         this.FLevel.text = STRING_COMMON.FORMAT_Level + String(_loc5_.Level);
         _loc2_ = _loc5_.NeedExp;
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         this.FTF_SoulExp.htmlText = "<font>" + _loc4_ + "</font><br>" + "<font>/</font><br>" + "<font>" + _loc2_ + "</font>";
         this.FMC_Blood_Bar.scaleY = Number(_loc4_) / Number(_loc2_);
         this.FTF_Cur_Blood.text = String(_loc5_.Life);
         if(_loc5_.Level >= CONST_BLOODPURGATORY.MAX_BLOODSOUL_LEVEL)
         {
            this.FTF_Next_Blood.text = "";
            return;
         }
         _loc3_++;
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BloodPurgatory_Attr,_loc3_) as TBloodSoul_Attr;
         this.FTF_Next_Blood.text = String(_loc5_.Life);
      }
      
      public function AddTimersGold() : void
      {
         ++this.FGlodTimers;
      }
      
      public function get GlodTimers() : int
      {
         return this.FGlodTimers;
      }
      
      public function set GlodTimers(param1:int) : void
      {
         this.FGlodTimers = param1;
      }
      
      public function get BloodSoulPanel() : MovieClip
      {
         return this.FBloodSoulPanel;
      }
      
      public function get MC_BloodBackGround() : MovieClip
      {
         return this.FMC_BloodBackGround;
      }
      
      public function set IsOpen(param1:Boolean) : void
      {
         this.FIsOpen = param1;
      }
      
      public function set Judge(param1:int) : void
      {
         this.FJudge = param1;
      }
      
      public function get Judge() : int
      {
         return this.FJudge;
      }
      
      public function get IsOpen() : Boolean
      {
         return this.FIsOpen;
      }
      
      public function set StuffId(param1:int) : void
      {
         this.FStuffId = param1;
      }
      
      public function get StuffId() : int
      {
         return this.FStuffId;
      }
   }
}

