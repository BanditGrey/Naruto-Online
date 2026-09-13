package Processors.Game.Lobby.ZhenAoYi
{
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TSkillReform;
   import Logics.SLogicsCore;
   import Logics.Skills.TSkill;
   import Logics.Skills.TSkills;
   import Logics.ZhenAoYi.TLevelCellLittle;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrameCopy;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_UNDERTOWN;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TLittleCell
   {
      
      protected var FCurData:TLevelCellLittle;
      
      protected var FCurReelData:TSkillReform;
      
      protected var FThisPanel:MovieClip;
      
      protected var Ftf_name:TextField;
      
      protected var Fmc_jiahao:MovieClip;
      
      protected var Fmc_slot:MovieClip;
      
      protected var Ftf_count:TextField;
      
      protected var Fmc_icon:MovieClip;
      
      protected var FMC_Lock:MovieClip;
      
      protected var FMC_End:MovieClip;
      
      protected var FMC_Price:MovieClip;
      
      protected var bmp:Bitmap;
      
      protected var FCurIndex:int;
      
      protected var FSlotIndex:int;
      
      protected var FPanelIndex:int;
      
      protected var FCurId:uint;
      
      protected var FIsMax:Boolean;
      
      protected var FBackClickFunction:Function;
      
      protected var FOnSkillOver:Function;
      
      protected var FOnSkillOut:Function;
      
      public function TLittleCell()
      {
         super();
         this.bmp = new Bitmap();
      }
      
      protected function Inilization() : void
      {
         this.Ftf_name = this.FThisPanel["tf_name"];
         this.Fmc_jiahao = this.FThisPanel["mc_jiahao"];
         this.Fmc_slot = this.FThisPanel["mc_slot"];
         this.Ftf_count = this.Fmc_slot["tf_count"];
         this.Fmc_icon = this.Fmc_slot["mc_icon"];
         this.FMC_Lock = this.FThisPanel["MC_Lock"];
         this.FMC_Lock.visible = false;
         this.FMC_Lock.mouseEnabled = false;
         this.FMC_End = this.FThisPanel["MC_End"];
         this.FMC_End.visible = false;
         this.FMC_Price = this.FThisPanel["MC_Price"];
         this.Fmc_icon.addChild(this.bmp);
         TGameUtil.setButtonMode(this.Fmc_jiahao,true);
         this.Fmc_jiahao.addEventListener(MouseEvent.CLICK,this.OnUpgradeClick);
         this.Fmc_slot.addEventListener(MouseEvent.MOUSE_MOVE,this.OnTalentOver);
         this.Fmc_slot.addEventListener(MouseEvent.ROLL_OUT,this.OnTalentOut);
      }
      
      protected function UpdateReelValue() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         this.FCurId = SLogicsCore.ZhenAoYiLogicData.CurIdVector[this.FCurIndex];
         _loc2_ = true;
         this.FIsMax = false;
         if(this.FCurId == 0)
         {
            this.FMC_End.visible = false;
            this.FCurReelData = this.FCurData.MinDate;
            if(this.FSlotIndex == 0)
            {
               _loc3_ = false;
               this.Fmc_jiahao.visible = true;
               this.FMC_Price.visible = true;
            }
            else
            {
               _loc3_ = true;
               this.Fmc_jiahao.visible = false;
               this.FMC_Price.visible = false;
            }
         }
         else if(this.FCurId < this.FCurData.MinDate.Identifier - 1)
         {
            _loc3_ = true;
            this.Fmc_jiahao.visible = false;
            this.FMC_End.visible = false;
            this.FCurReelData = this.FCurData.MinDate;
            this.FMC_Price.visible = false;
         }
         else if(this.FCurId >= this.FCurData.MinDate.Identifier - 1 && this.FCurId < this.FCurData.MaxDate.Identifier)
         {
            _loc2_ = true;
            _loc3_ = false;
            this.Fmc_jiahao.visible = true;
            this.FMC_End.visible = false;
            this.FMC_Price.visible = true;
            _loc1_ = 0;
            while(_loc1_ < this.FCurData.Count)
            {
               if(this.FCurId == this.FCurData.AllLevelVector[_loc1_].Conditions)
               {
                  this.FCurReelData = this.FCurData.AllLevelVector[_loc1_];
                  break;
               }
               _loc1_++;
            }
         }
         else
         {
            _loc3_ = false;
            this.Fmc_jiahao.visible = false;
            this.FMC_End.visible = true;
            this.FMC_Price.visible = false;
            this.FCurReelData = this.FCurData.MaxDate;
            this.FIsMax = true;
         }
         this.Ftf_name.text = this.FCurReelData.Name;
         if(this.FIsMax)
         {
            this.Ftf_count.text = this.FCurReelData.Level + "/" + this.FCurData.MaxDate.Level;
         }
         else
         {
            this.Ftf_count.text = this.FCurReelData.Level - 1 + "/" + this.FCurData.MaxDate.Level;
         }
         this.FMC_Price.TF_Price.text = this.FCurReelData.ConsumeVector[0][1];
         if(!this.FIsMax)
         {
            if(!this.GetBoo())
            {
               _loc2_ = false;
            }
            if(!this.GetBooo())
            {
               _loc3_ = true;
               this.Fmc_jiahao.visible = false;
               this.FMC_End.visible = false;
               this.FMC_Price.visible = false;
            }
         }
         TGameUtil.setButtonMode(this.Fmc_jiahao,_loc2_);
         this.FMC_Lock.visible = _loc3_;
         if(_loc3_)
         {
            this.FThisPanel.filters = [TGameUtil.GaryColorFilters];
         }
         else
         {
            this.FThisPanel.filters = [];
         }
      }
      
      protected function GetBooo() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:TSkill = null;
         var _loc3_:TSkills = null;
         _loc3_ = SLogicsCore.Character.MainHero.Skills;
         _loc1_ = 0;
         while(_loc1_ < _loc3_.Count)
         {
            _loc2_ = _loc3_.GetSkillByIndex(_loc1_);
            if(_loc2_.Identifier == this.FCurReelData.ReplaceSkillID)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      protected function GetBoo() : Boolean
      {
         var _loc1_:Vector.<Array> = null;
         _loc1_ = this.FCurReelData.ConsumeVector;
         if(SLogicsCore.Character.AwakenGeneralsSoul >= _loc1_[0][1])
         {
            return true;
         }
         return false;
      }
      
      protected function OnUpgradeClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(this.FBackClickFunction != null)
         {
            _loc2_ = new ConsumeFrameCopy(STRING_UNDERTOWN.STRING_UNDERTOWN_30).DescribeString;
            _loc2_ = TUtilityString.Format(_loc2_,this.FCurReelData.Name,this.FCurReelData.ConsumeVector[0][1]);
            this.FBackClickFunction(_loc2_,this.FCurReelData.ReplaceSkillID);
         }
      }
      
      protected function OnTalentOver(param1:MouseEvent) : void
      {
         if(this.FOnSkillOver != null)
         {
            this.FOnSkillOver(this.FCurReelData,this.FIsMax);
         }
      }
      
      protected function OnTalentOut(param1:MouseEvent) : void
      {
         if(this.FOnSkillOut != null)
         {
            this.FOnSkillOut();
         }
      }
      
      public function set CurIndex(param1:int) : void
      {
         this.FCurIndex = param1;
      }
      
      public function set BackClickFunction(param1:Function) : void
      {
         this.FBackClickFunction = param1;
      }
      
      public function get OnSkillOver() : Function
      {
         return this.FOnSkillOver;
      }
      
      public function set OnSkillOver(param1:Function) : void
      {
         this.FOnSkillOver = param1;
      }
      
      public function get OnSkillOut() : Function
      {
         return this.FOnSkillOut;
      }
      
      public function set OnSkillOut(param1:Function) : void
      {
         this.FOnSkillOut = param1;
      }
      
      public function SetPanel(param1:MovieClip, param2:int, param3:int) : void
      {
         this.FThisPanel = param1;
         this.FSlotIndex = param2;
         this.FPanelIndex = param3;
         this.Inilization();
      }
      
      public function Update(param1:TLevelCellLittle) : void
      {
         this.FCurData = param1;
         this.UpdateReelValue();
      }
      
      public function LogicsPerform() : void
      {
         if(this.FCurReelData)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_Inventory,this.bmp,CONST_MODULES.MODULE_ZhenAoYi,this.FCurReelData.Icon);
         }
      }
   }
}

