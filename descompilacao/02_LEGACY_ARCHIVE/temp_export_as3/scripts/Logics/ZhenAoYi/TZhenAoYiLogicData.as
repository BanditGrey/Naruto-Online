package Logics.ZhenAoYi
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TSkillReform;
   import Logics.SLogicsCore;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TZhenAoYiLogicData
   {
      
      public static const SIX:int = 6;
      
      protected var FCurNeedData:Vector.<TSkillReform>;
      
      protected var FGongJiData:Vector.<TSkillReform>;
      
      protected var FFuZhuData:Vector.<TSkillReform>;
      
      protected var FShouHuData:Vector.<TSkillReform>;
      
      protected var FCurIdVector:Vector.<uint>;
      
      protected var FOnLineGiftTime:uint;
      
      protected var FOnLineGiftCurTime:uint;
      
      public var OnMiLineGiftTime:uint;
      
      public var OnMiLineGiftCurTime:uint;
      
      protected var FVectorLevelCell1:TLevelCell;
      
      protected var FVectorLevelCell2:TLevelCell;
      
      public function TZhenAoYiLogicData()
      {
         super();
         this.FVectorLevelCell1 = new TLevelCell();
         this.FVectorLevelCell2 = new TLevelCell();
         this.FCurIdVector = new Vector.<uint>(SIX);
      }
      
      public function set OnLineGiftTime(param1:uint) : void
      {
         this.FOnLineGiftTime = param1;
      }
      
      public function get OnLineGiftTime() : uint
      {
         return this.FOnLineGiftTime;
      }
      
      public function set OnLineGiftCurTime(param1:uint) : void
      {
         this.FOnLineGiftCurTime = param1;
      }
      
      public function get OnLineGiftCurTime() : uint
      {
         return this.FOnLineGiftCurTime;
      }
      
      public function get CurIdVector() : Vector.<uint>
      {
         return this.FCurIdVector;
      }
      
      public function get VectorLevelCell1() : TLevelCell
      {
         return this.FVectorLevelCell1;
      }
      
      public function get VectorLevelCell2() : TLevelCell
      {
         return this.FVectorLevelCell2;
      }
      
      public function SetVectorLevelCellByType(param1:uint) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Vector.<TSkillReform> = null;
         var _loc4_:TLevelCell = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         this.FVectorLevelCell1.Clear();
         this.FVectorLevelCell2.Clear();
         switch(param1)
         {
            case 1:
               _loc3_ = this.GongJiData;
               break;
            case 2:
               _loc3_ = this.FuZhuData;
               break;
            case 3:
               _loc3_ = this.ShouHuData;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            if(_loc3_[_loc2_].TalentType <= 3)
            {
               _loc4_ = this.FVectorLevelCell1;
            }
            else
            {
               _loc4_ = this.FVectorLevelCell2;
            }
            _loc5_ = _loc3_[_loc2_].Position;
            _loc4_.GetCellLittleByType(_loc5_ - 1).add(_loc3_[_loc2_]);
            _loc2_++;
         }
      }
      
      public function get CurNeedData() : Vector.<TSkillReform>
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TBins = null;
         var _loc4_:TSkillReform = null;
         var _loc5_:int = 0;
         if(!this.FCurNeedData)
         {
            this.FCurNeedData = new Vector.<TSkillReform>();
            _loc3_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_SkillReform);
            _loc2_ = _loc3_.Count;
            _loc5_ = int(SLogicsCore.Character.MainHero.Profession);
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc4_ = _loc3_.GetDatebaseByIndex(_loc1_) as TSkillReform;
               if(_loc4_.Professor == _loc5_)
               {
                  this.FCurNeedData.push(_loc4_);
               }
               _loc1_++;
            }
         }
         return this.FCurNeedData;
      }
      
      public function get GongJiData() : Vector.<TSkillReform>
      {
         if(!this.FGongJiData)
         {
            this.YouDainYiSi();
         }
         return this.FGongJiData;
      }
      
      public function get FuZhuData() : Vector.<TSkillReform>
      {
         if(!this.FFuZhuData)
         {
            this.YouDainYiSi();
         }
         return this.FFuZhuData;
      }
      
      public function get ShouHuData() : Vector.<TSkillReform>
      {
         if(!this.FShouHuData)
         {
            this.YouDainYiSi();
         }
         return this.FShouHuData;
      }
      
      protected function YouDainYiSi() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TSkillReform = null;
         this.FGongJiData = new Vector.<TSkillReform>();
         this.FFuZhuData = new Vector.<TSkillReform>();
         this.FShouHuData = new Vector.<TSkillReform>();
         _loc2_ = int(this.CurNeedData.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.CurNeedData[_loc1_];
            switch(_loc3_.Subtype)
            {
               case 1:
                  this.FGongJiData.push(_loc3_);
                  break;
               case 2:
                  this.FFuZhuData.push(_loc3_);
                  break;
               case 3:
                  this.FShouHuData.push(_loc3_);
            }
            _loc1_++;
         }
      }
   }
}

