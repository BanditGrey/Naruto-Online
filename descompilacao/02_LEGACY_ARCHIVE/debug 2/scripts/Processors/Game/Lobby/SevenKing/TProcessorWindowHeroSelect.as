package Processors.Game.Lobby.SevenKing
{
   import Externals.*;
   import Foundation.Network.*;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Agent.*;
   import Logics.Characters.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.SevenKing.*;
   import Processors.Game.Battle.Character.TActive;
   import Processors.Game.Battle.Character.TPoolRole;
   import Processors.Game.Lobby.TacticalDeployment.TDeploymentTip;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import flash.display.*;
   import flash.events.*;
   import flash.utils.*;
   
   public class TProcessorWindowHeroSelect extends TUIComponent
   {
      
      public static const CONST_HERO:uint = 6;
      
      protected var Bg_Sp:Shape;
      
      protected var FScene:MovieClip;
      
      protected var FCharacter:TCharacter;
      
      protected var FSevenKingData:TSevenKingData;
      
      protected var FTotlePage:uint;
      
      protected var FCurPage:uint;
      
      protected var FSelectHeroId:uint;
      
      protected var FHeroHeadBitmap:Vector.<Bitmap>;
      
      protected var FHeroHeadId:Vector.<uint>;
      
      protected var FActiveSelf:TActive;
      
      protected var FActiveEnemy:TActive;
      
      protected var FHeroInfoTip:TDeploymentTip;
      
      protected var FTipsScene:MovieClip;
      
      public function TProcessorWindowHeroSelect(param1:TUIComponent, param2:TSevenKingData)
      {
         var _loc3_:uint = 0;
         var _loc4_:Bitmap = null;
         super(param1);
         this.Bg_Sp = new Shape();
         this.Bg_Sp.graphics.beginFill(0,0.1);
         this.Bg_Sp.graphics.drawRect(0,0,CONST_COMMON.STAGE_Max_Width,CONST_COMMON.STAGE_Max_Height);
         this.Bg_Sp.graphics.endFill();
         addChild(this.Bg_Sp);
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_SEVENKING.RESOURCESID_CLASSNAME_FightSelect) as MovieClip;
         addChild(this.FScene);
         this.FSevenKingData = param2;
         this.FCharacter = SLogicsCore.Character;
         this.FTotlePage = 1;
         this.FCurPage = 1;
         this.FScene.btn_left.addEventListener(MouseEvent.CLICK,this.OnLeft);
         this.FScene.btn_right.addEventListener(MouseEvent.CLICK,this.OnRight);
         this.FScene.mc_Report.btn_bestSingleShow.addEventListener(MouseEvent.CLICK,this.OnReportView);
         this.FScene.mc_Report.btn_bestAllShow.addEventListener(MouseEvent.CLICK,this.OnReportView);
         this.FScene.mc_Report.btn_firstSingleShow.addEventListener(MouseEvent.CLICK,this.OnReportView);
         this.FScene.mc_Report.btn_firstAllShow.addEventListener(MouseEvent.CLICK,this.OnReportView);
         this.FHeroHeadBitmap = new Vector.<Bitmap>(CONST_HERO);
         this.FHeroHeadId = new Vector.<uint>(CONST_HERO);
         _loc3_ = 0;
         while(_loc3_ < CONST_HERO)
         {
            _loc4_ = new Bitmap();
            this.FScene["mc_Hero_" + _loc3_].mc_head.addChild(_loc4_);
            this.FHeroHeadBitmap[_loc3_] = _loc4_;
            TGameUtil.setButtonMode(this.FScene["mc_Hero_" + _loc3_],true);
            this.FScene["mc_Hero_" + _loc3_].addEventListener(MouseEvent.CLICK,this.OnHeroSelect);
            this.FScene["mc_Hero_" + _loc3_].addEventListener(MouseEvent.MOUSE_MOVE,this.ShowHeroInfoTip);
            this.FScene["mc_Hero_" + _loc3_].addEventListener(MouseEvent.MOUSE_OUT,this.HideHeroInfoTip);
            _loc3_++;
         }
         this.FScene.btn_start.addEventListener(MouseEvent.CLICK,this.OnFightReq);
         this.FScene.btn_close.addEventListener(MouseEvent.CLICK,this.OnClose);
         this.FActiveSelf = TPoolRole.GetActive(this,this.FCharacter.MainHero.Identifier,CONST_MODULES.MODULE_SevenKing,true);
         this.FScene.mc_self.addChild(this.FActiveSelf);
         this.FActiveEnemy = TPoolRole.GetActive(this,this.FCharacter.MainHero.Identifier,CONST_MODULES.MODULE_SevenKing,true);
         this.FScene.mc_enemy.addChild(this.FActiveEnemy);
         this.FActiveEnemy.addEventListener(MouseEvent.MOUSE_MOVE,this.ShowEnemyInfoTip);
         this.FActiveEnemy.addEventListener(MouseEvent.MOUSE_OUT,this.HideEnamyInfoTip);
         this.FHeroInfoTip = new TDeploymentTip(this.Parent);
         this.FHeroInfoTip.Visible = false;
         this.FTipsScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_GroupMonstonTip) as MovieClip;
         this.FTipsScene.visible = false;
      }
      
      protected function CheckBtn() : void
      {
         TGameUtil.setButtonMode(this.FScene.btn_left,this.FCurPage > 1);
         TGameUtil.setButtonMode(this.FScene.btn_right,this.FCurPage < this.FTotlePage);
         this.FScene.tf_page.text = this.FCurPage + "/" + this.FTotlePage;
      }
      
      protected function UpdataUI() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:THero = null;
         _loc3_ = -1;
         _loc1_ = 0;
         while(_loc1_ < CONST_HERO)
         {
            _loc2_ = _loc1_ + (this.FCurPage - 1) * CONST_HERO;
            if(_loc2_ < this.FCharacter.Heros.Count)
            {
               _loc4_ = this.FCharacter.Heros.GetHeroByIndex(_loc2_);
               this.FHeroHeadId[_loc1_] = _loc4_.SmallID;
               if(_loc4_.Identifier == this.FSelectHeroId)
               {
                  _loc3_ = int(_loc1_);
               }
               this.FScene["mc_Hero_" + _loc1_].tf_Level.text = SLogicsCore.Character.MainHero.GetLevelStrByLevel(_loc4_.Level);
               if(_loc4_.IsMain)
               {
                  this.FScene["mc_Hero_" + _loc1_].tf_name.text = this.FCharacter.NickName;
               }
               else
               {
                  this.FScene["mc_Hero_" + _loc1_].tf_name.text = _loc4_.Name;
               }
               this.FScene["mc_Hero_" + _loc1_].tf_name.textColor = CONST_COMMON.QUALITYCOLOR_INDEX[_loc4_.Quality];
               this.FScene["mc_Hero_" + _loc1_].visible = true;
            }
            else
            {
               this.FHeroHeadId[_loc1_] = 0;
               this.FScene["mc_Hero_" + _loc1_].visible = false;
            }
            _loc1_++;
         }
         if(_loc3_ >= 0)
         {
            this.FScene.mc_select.visible = true;
            this.FScene.mc_select.x = 328 + _loc3_ % 2 * 97;
            this.FScene.mc_select.y = 227 + int(_loc3_ / 2) * 86;
            this.FScene.mc_select.mouseEnabled = false;
         }
         else
         {
            this.FScene.mc_select.visible = false;
         }
         this.FActiveSelf.ResetActive(this,this.FSelectHeroId,CONST_MODULES.MODULE_SevenKing,true);
         this.FScene.mc_self.addChild(this.FActiveSelf);
         this.FActiveSelf.direction = false;
      }
      
      protected function OnLeft(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         --this.FCurPage;
         if(this.FCurPage < 1)
         {
            this.FCurPage = 1;
         }
         this.UpdataUI();
         this.CheckBtn();
      }
      
      protected function OnRight(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         ++this.FCurPage;
         if(this.FCurPage > this.FTotlePage)
         {
            this.FCurPage = this.FTotlePage;
         }
         this.UpdataUI();
         this.CheckBtn();
      }
      
      protected function OnReportView(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         switch(param1.currentTarget.name)
         {
            case "btn_firstSingleShow":
               _loc2_ = 0;
               break;
            case "btn_bestSingleShow":
               _loc2_ = 1;
               break;
            case "btn_firstAllShow":
               _loc2_ = 2;
               break;
            case "btn_bestAllShow":
               _loc2_ = 3;
         }
         SExternalCore.NavigateToFightReport(this.FSevenKingData.ReportID[_loc2_]);
      }
      
      protected function OnFightReq(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_SevenKing_FightReq);
         _loc3_ = _loc2_.Data;
         _loc3_.writeByte(1);
         _loc3_.writeUnsignedInt(this.FSelectHeroId);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         Visible = false;
      }
      
      protected function OnHeroSelect(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:uint = 0;
         _loc2_ = uint(int(String(param1.currentTarget.name).slice(8)));
         _loc2_ += (this.FCurPage - 1) * CONST_HERO;
         _loc4_ = param1.currentTarget as MovieClip;
         _loc3_ = int(_loc4_.name.split("_")[2]);
         if(_loc2_ >= this.FCharacter.Heros.Count)
         {
            return;
         }
         _loc5_ = this.FCharacter.Heros.GetHeroByIndex(_loc2_).Identifier;
         if(this.FSelectHeroId == _loc5_)
         {
            return;
         }
         this.FSelectHeroId = _loc5_;
         this.UpdataUI();
      }
      
      protected function OnClose(param1:MouseEvent) : void
      {
         Visible = false;
      }
      
      protected function ShowHeroInfoTip(param1:MouseEvent) : void
      {
         var _loc2_:THero = null;
         var _loc3_:uint = 0;
         var _loc4_:MovieClip = null;
         _loc4_ = param1.currentTarget as MovieClip;
         _loc3_ = uint(_loc4_.name.split("_")[2]);
         if(_loc3_ + (this.FCurPage - 1) * CONST_HERO >= this.FCharacter.Heros.Count)
         {
            return;
         }
         _loc2_ = this.FCharacter.Heros.GetHeroByIndex(_loc3_ + (this.FCurPage - 1) * CONST_HERO);
         if(_loc2_ != null)
         {
            this.FHeroInfoTip.Visible = true;
            this.FHeroInfoTip.SetHeroData(_loc2_);
         }
      }
      
      protected function HideHeroInfoTip(param1:MouseEvent) : void
      {
         this.FHeroInfoTip.Visible = false;
      }
      
      protected function ShowEnemyInfoTip(param1:MouseEvent) : void
      {
         var _loc2_:TBins = null;
         var _loc3_:TBins = null;
         var _loc4_:THeroTalent = null;
         var _loc5_:TSkillConfig = null;
         _loc2_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_SkillConfig);
         _loc3_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_HeroTalent);
         if(this.FActiveEnemy.EnemyData != null)
         {
            this.FTipsScene.tf_name.text = this.FActiveEnemy.EnemyData.Name;
            this.FTipsScene.tf_level.text = SLogicsCore.Character.MainHero.GetLevelStrByLevel(this.FActiveEnemy.EnemyData.Level);
            this.FTipsScene.tf_type.text = STRING_COMMON.TYPE_PROFESSIONS[this.FActiveEnemy.EnemyData.Profession];
            this.FTipsScene.tf_health.text = this.FActiveEnemy.EnemyData.Hp;
            _loc4_ = _loc3_.GetDatebaseByIdentifier(this.FActiveEnemy.EnemyData.TalentId) as THeroTalent;
            this.FTipsScene.tf_talent.text = _loc4_ ? _loc4_.TalentName : STRING_COMMON.COMMON_NONE;
            _loc5_ = _loc2_.GetDatebaseByIdentifier(this.FActiveEnemy.EnemyData.Skill) as TSkillConfig;
            this.FTipsScene.tf_skill.text = _loc5_.Name;
            this.FTipsScene.tf_skilldesc.text = _loc5_.Desc;
         }
         if(this.FTipsScene != null)
         {
            this.FTipsScene.visible = true;
            this.FTipsScene.x = mouseX + 15;
            this.FTipsScene.y = mouseY;
            addChildAt(this.FTipsScene,numChildren - 1);
            if(this.FTipsScene.x > CONST_COMMON.STAGE_Width - this.FTipsScene.width)
            {
               this.FTipsScene.x = mouseX - this.FTipsScene.width - 5;
            }
            if(this.FTipsScene.y > CONST_COMMON.STAGE_Height - this.FTipsScene.height)
            {
               this.FTipsScene.y = mouseY - this.FTipsScene.height - 5;
            }
         }
      }
      
      protected function HideEnamyInfoTip(param1:MouseEvent) : void
      {
         FUICore.MouseCaptureRelease(this.FActiveEnemy);
         if(this.FTipsScene != null)
         {
            this.FTipsScene.visible = false;
         }
      }
      
      public function ReportReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_SevenKing_ReportReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      public function UpdataReport() : void
      {
         if(this.FSevenKingData.ReportID[0] == "" || this.FSevenKingData.ReportID[0] == null)
         {
            this.FScene.mc_Report.tf_firstSingleName.text = STRING_COMMON.COMMON_NONE;
            this.FScene.mc_Report.btn_firstSingleShow.visible = false;
         }
         else
         {
            this.FScene.mc_Report.tf_firstSingleName.text = this.FSevenKingData.ReportUserName[0];
            this.FScene.mc_Report.btn_firstSingleShow.visible = true;
         }
         if(this.FSevenKingData.ReportID[1] == "" || this.FSevenKingData.ReportID[1] == null)
         {
            this.FScene.mc_Report.tf_bestSingleName.text = STRING_COMMON.COMMON_NONE;
            this.FScene.mc_Report.btn_bestSingleShow.visible = false;
         }
         else
         {
            this.FScene.mc_Report.tf_bestSingleName.text = this.FSevenKingData.ReportUserName[1];
            this.FScene.mc_Report.btn_bestSingleShow.visible = true;
         }
         if(this.FSevenKingData.ReportID[2] == "" || this.FSevenKingData.ReportID[2] == null)
         {
            this.FScene.mc_Report.tf_firstAllName.text = STRING_COMMON.COMMON_NONE;
            this.FScene.mc_Report.btn_firstAllShow.visible = false;
         }
         else
         {
            this.FScene.mc_Report.tf_firstAllName.text = this.FSevenKingData.ReportUserName[2];
            this.FScene.mc_Report.btn_firstAllShow.visible = true;
         }
         if(this.FSevenKingData.ReportID[3] == "" || this.FSevenKingData.ReportID[3] == null)
         {
            this.FScene.mc_Report.tf_bestAllName.text = STRING_COMMON.COMMON_NONE;
            this.FScene.mc_Report.btn_bestAllShow.visible = false;
         }
         else
         {
            this.FScene.mc_Report.tf_bestAllName.text = this.FSevenKingData.ReportUserName[3];
            this.FScene.mc_Report.btn_bestAllShow.visible = true;
         }
      }
      
      public function SetHeroFight(param1:TSevenHeroArmy) : void
      {
         this.FCharacter.Heros.Sort();
         this.FTotlePage = Math.max(int(this.FCharacter.Heros.Count - 1) / CONST_HERO + 1,1);
         this.FCurPage = 1;
         if(this.FSelectHeroId == 0)
         {
            this.FSelectHeroId = this.FCharacter.GetMainHero().Identifier;
         }
         this.FActiveEnemy.ResetActive(this,param1.Model,CONST_MODULES.MODULE_SevenKing,true);
         this.FScene.mc_enemy.addChild(this.FActiveEnemy);
         this.FActiveEnemy.direction = false;
         this.UpdataUI();
         this.CheckBtn();
      }
      
      public function ShowHeroHead() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < CONST_HERO)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,this.FHeroHeadBitmap[_loc1_],CONST_MODULES.MODULE_SevenKing,this.FHeroHeadId[_loc1_]);
            _loc1_++;
         }
         this.FActiveSelf.UpdateActive();
         this.FActiveEnemy.UpdateActive();
      }
   }
}

