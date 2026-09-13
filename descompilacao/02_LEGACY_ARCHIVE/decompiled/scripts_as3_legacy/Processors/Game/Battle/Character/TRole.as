package Processors.Game.Battle.Character
{
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.Textures.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.Battle.*;
   import Logics.Battle.model.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.SLogicsCore;
   import Processors.Game.Battle.*;
   import Processors.Game.Battle.Effect.*;
   import Processors.Game.Battle.GoneWord.TGoneWord;
   import Resources.Constants.*;
   import flash.display.*;
   import flash.events.*;
   import flash.utils.*;
   import ghostcat.util.easing.Expo;
   import ghostcat.util.easing.TweenUtil;
   
   public class TRole extends TBaseRole
   {
      
      public static const CONST_BUFF_Const:int = 7;
      
      public static const CONST_BUFF_Width:Number = 22;
      
      public static const CONST_BUFF_Height:Number = 22;
      
      public static const CONST_BUFF_StampX_Left:int = -50;
      
      public static const CONST_BUFF_StampX_Right:int = 50;
      
      public static const CONST_BUFF_StampY:Number = -130;
      
      protected var FWaitNextCommand:Boolean;
      
      protected var FStatusGridFile:Boolean;
      
      protected var FSkillBins:TBins;
      
      protected var FBuffBins:TBins;
      
      protected var FHideFrame:int;
      
      protected var FBattleStage:TBattleStage;
      
      protected var FBuffIdVect:Vector.<uint>;
      
      protected var FBuffTurnVect:Vector.<uint>;
      
      protected var FBuffSpriteVect:Vector.<Sprite>;
      
      protected var FIsNewBuffVect:Vector.<Boolean>;
      
      protected var FStatusGoneWordDict:Dictionary;
      
      protected var FOnEffectEnd:Function;
      
      protected var FTextFunction:Function;
      
      protected var FActiveCallBack:Function;
      
      protected var FActiveTime:uint;
      
      protected var FOnBuffMouseMove:Function;
      
      protected var FOnBuffMouseRollOut:Function;
      
      public function TRole(param1:TUIComponent, param2:TRoleBattleInfo, param3:uint, param4:TBattleStage, param5:Boolean = false, param6:Function = null, param7:int = 0)
      {
         super(param1,param2,param3,param5,param7);
         this.FBattleStage = param4;
         this.FTextFunction = param6;
         this.FStatusGoneWordDict = new Dictionary();
         this.FSkillBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_SkillConfig);
         this.FBuffBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BuffEffect);
         this.FBuffIdVect = new Vector.<uint>();
         this.FBuffTurnVect = new Vector.<uint>();
         this.FBuffSpriteVect = new Vector.<Sprite>();
         this.FIsNewBuffVect = new Vector.<Boolean>();
         this.InitCharacter();
      }
      
      protected function InitCharacter() : void
      {
         var _loc1_:Sprite = null;
         this.FWaitNextCommand = false;
         FIsAntiColorBlackWhite = false;
         FIsRedAntiColor = false;
         this.FStatusGridFile = false;
         this.FHideFrame = -1;
         while(this.FBuffSpriteVect.length)
         {
            _loc1_ = this.FBuffSpriteVect.pop();
            this.SaveBitmapSprite(_loc1_);
         }
         this.FBuffIdVect.length = 0;
         this.FBuffTurnVect.length = 0;
         this.FBuffSpriteVect.length = 0;
         this.FIsNewBuffVect.length = 0;
         if(FResourcesType != TYPE_NONE && FResourcesType != TYPE_SOULFORMATION)
         {
            this.SetPosition(SBattleConfig.GetPostionByCamyPos(Camp,Pos,SBattleConfig.Type_PostionX),SBattleConfig.GetPostionByCamyPos(Camp,Pos,SBattleConfig.Type_PostionY));
         }
      }
      
      protected function PlayShowUI(param1:int) : void
      {
         var SkillName:String;
         var Skill:TSkillConfig = null;
         var ShowUIEnd:Function = null;
         var SkillId:int = param1;
         ShowUIEnd = function():void
         {
            DelStatus(CONST_BATTLE.TEXT_FIGHT_STATUS_OtherTurn,CONST_BATTLE.TEXT_FIGHT_STATUS_Punch);
            FSkillId = SkillId;
            PlaySkill();
         };
         if(stage == null)
         {
            return;
         }
         SkillName = "";
         if(FEnemy != null)
         {
            if(!FEnemy.IsBoss)
            {
               this.DelStatus(CONST_BATTLE.TEXT_FIGHT_STATUS_OtherTurn,CONST_BATTLE.TEXT_FIGHT_STATUS_Punch);
               FSkillId = SkillId;
               PlaySkill();
               return;
            }
            Skill = this.FSkillBins.GetDatebaseByIdentifier(SkillId) as TSkillConfig;
         }
         else if(FHero != null)
         {
            Skill = this.FSkillBins.GetDatebaseByIdentifier(SkillId) as TSkillConfig;
         }
         else
         {
            if(SoulFormationID <= 0)
            {
               PlaySkill();
               return;
            }
            Skill = this.FSkillBins.GetDatebaseByIdentifier(SkillId) as TSkillConfig;
         }
         SkillName = Skill.Name;
         TEffectControl.ShowUIEffect(this.FBattleStage,FBigHeadId,Camp,SkillName,ShowUIEnd);
         SLogicsCore.SignalPost(CONST_SIGNAL.SIGNALDESTINATION_SOUND,CONST_MUSIC.PLAY_SOUND_EFFECT,SkillSound,true);
      }
      
      protected function ShowGridFile() : void
      {
         var _loc1_:int = 0;
         if(FTargets == null)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < FTargets.length)
         {
            if(FResults[_loc1_].CMD != 0)
            {
               TEffectControl.ShowPublicEffect(FTargets[_loc1_],CONST_BATTLE.Public_Effect_Daoguang,0,0,this.EndGridFile);
               if(this.FTextFunction != null)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Float,FTargets[_loc1_].Camp == 0 ? -1 : 1,FTargets[_loc1_].x,FTargets[_loc1_].y - FTargets[_loc1_].RoleHeight,int(FResults[_loc1_].ResultInfo.HurtHp));
               }
               FTargets[_loc1_].CurHealth -= FResults[_loc1_].ResultInfo.HurtHp;
               FTargets[_loc1_].ActivePlay(TYPE_ACTIVE_ATTACKED);
               if(FTargets == null)
               {
                  return;
               }
            }
            _loc1_++;
         }
      }
      
      protected function EndGridFile() : void
      {
         var _loc1_:Function = null;
         var _loc2_:uint = 0;
         this.FStatusGridFile = false;
         FBitmap.visible = true;
         _loc1_ = FCallBackDict[TYPE_ACTIVE_GRIDFILE];
         _loc2_ = uint(FTimeDict[TYPE_ACTIVE_GRIDFILE]);
         if(_loc1_ != null)
         {
            _loc1_(_loc2_);
         }
      }
      
      protected function GetSameBuffIndex(param1:Vector.<uint>, param2:int) : Vector.<int>
      {
         var _loc3_:int = 0;
         var _loc4_:Vector.<int> = null;
         var _loc5_:TBuffEffect = null;
         var _loc6_:TBuffEffect = null;
         _loc4_ = new Vector.<int>();
         _loc6_ = this.FBuffBins.GetDatebaseByIdentifier(param2) as TBuffEffect;
         _loc4_.push(_loc6_.Weight);
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc5_ = this.FBuffBins.GetDatebaseByIdentifier(param1[_loc3_]) as TBuffEffect;
            if(_loc5_.BuffType == _loc6_.BuffType && this.GetAlterSame(_loc5_.AlterVect,_loc6_.AlterVect) && _loc5_.Buffkey == _loc6_.Buffkey)
            {
               _loc4_.push(_loc3_);
               _loc4_.push(_loc5_.Weight);
            }
            _loc3_++;
         }
         return _loc4_;
      }
      
      protected function DelSameTypeBuffIndex(param1:uint) : void
      {
         var _loc2_:* = 0;
         var _loc3_:TBuffEffect = null;
         _loc2_ = 0;
         while(_loc2_ < this.FBuffIdVect.length)
         {
            _loc3_ = this.FBuffBins.GetDatebaseByIdentifier(this.FBuffIdVect[_loc2_]) as TBuffEffect;
            if(_loc3_.BuffType == param1 && (_loc3_.Identifier != 13500082 && _loc3_.Identifier != 13500101 && _loc3_.Identifier != 13500109 && _loc3_.Identifier != 13500110 && _loc3_.Identifier != 13500115 && _loc3_.Identifier != 13500120 && _loc3_.Identifier != 13500121 && _loc3_.Identifier != 13500122 && _loc3_.Identifier != 13500113 && _loc3_.Identifier != 13500123 && _loc3_.Identifier != 13500124 && _loc3_.Identifier != 13500125 && _loc3_.Identifier != 13500126 && _loc3_.Identifier != 13500128 && _loc3_.Identifier != 13500129 && _loc3_.Identifier != 13500131 && _loc3_.Identifier != 13500064 && _loc3_.Identifier != 13500060 && _loc3_.Identifier != 13500135 && _loc3_.Identifier != 13500136 && _loc3_.Identifier != 13500137 && _loc3_.Identifier != 13500139 && _loc3_.Identifier != 13500141 && _loc3_.Identifier != 13500142 && _loc3_.Identifier != 13500143 && _loc3_.Identifier != 13500144 && _loc3_.Identifier != 13500145 && _loc3_.Identifier != 13500146 && _loc3_.Identifier != 13500147 && _loc3_.Identifier != 13500148 && _loc3_
            .Identifier != 13500149 && _loc3_.Identifier != 13500150))
            {
               this.DelBuffs(_loc3_.Identifier);
               _loc2_--;
            }
            _loc2_++;
         }
      }
      
      protected function GetAlterSame(param1:Vector.<uint>, param2:Vector.<uint>) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc5_ = param2.indexOf(param1[_loc3_]);
            if(_loc5_ >= 0)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      protected function DelBuffs(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Sprite = null;
         _loc2_ = this.FBuffIdVect.indexOf(param1);
         if(_loc2_ >= 0)
         {
            this.FBuffIdVect.splice(_loc2_,1);
            this.FBuffTurnVect.splice(_loc2_,1);
            _loc3_ = this.FBuffSpriteVect[_loc2_];
            this.FBuffSpriteVect.splice(_loc2_,1);
            this.FIsNewBuffVect.splice(_loc2_,1);
            this.SaveBitmapSprite(_loc3_);
         }
      }
      
      protected function DelBuffByIndex(param1:int) : void
      {
         var _loc2_:Sprite = null;
         if(param1 >= 0 && param1 < this.FBuffIdVect.length)
         {
            this.FBuffIdVect.splice(param1,1);
            this.FBuffTurnVect.splice(param1,1);
            _loc2_ = this.FBuffSpriteVect[param1];
            this.FBuffSpriteVect.splice(param1,1);
            this.FIsNewBuffVect.splice(param1,1);
            this.SaveBitmapSprite(_loc2_);
         }
      }
      
      protected function CheckBuffContinued(param1:uint, param2:int) : Boolean
      {
         var _loc3_:TBuffEffect = null;
         _loc3_ = this.FBuffBins.GetDatebaseByIdentifier(param1) as TBuffEffect;
         if(_loc3_ != null)
         {
            if(_loc3_.Continued == param2)
            {
               return true;
            }
         }
         return false;
      }
      
      protected function SaveBitmapSprite(param1:Sprite) : void
      {
         if(param1)
         {
            if(param1.hasEventListener(MouseEvent.MOUSE_MOVE))
            {
               param1.removeEventListener(MouseEvent.MOUSE_MOVE,this.OnMouseMove);
            }
            if(param1.hasEventListener(MouseEvent.ROLL_OUT))
            {
               param1.removeEventListener(MouseEvent.ROLL_OUT,this.OnRollOut);
            }
         }
         TPoolBitmap.SaveBitmapSprite(param1);
      }
      
      protected function OnMouseMove(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TBuffEffect = null;
         _loc4_ = this.FBuffSpriteVect.indexOf(param1.target);
         if(_loc4_ < 0)
         {
            return;
         }
         _loc2_ = int(this.FBuffIdVect[_loc4_]);
         _loc3_ = int(this.FBuffTurnVect[_loc4_]);
         _loc5_ = this.FBuffBins.GetDatebaseByIdentifier(_loc2_) as TBuffEffect;
         if(this.FOnBuffMouseMove != null)
         {
            this.FOnBuffMouseMove(this,_loc5_.Name,_loc3_,_loc5_.Description);
         }
      }
      
      protected function OnRollOut(param1:MouseEvent) : void
      {
         if(this.FOnBuffMouseRollOut != null)
         {
            this.FOnBuffMouseRollOut(this);
         }
      }
      
      public function get BattleStage() : TBattleStage
      {
         return this.FBattleStage;
      }
      
      public function get OnEffectEnd() : Function
      {
         return this.FOnEffectEnd;
      }
      
      public function set OnEffectEnd(param1:Function) : void
      {
         this.FOnEffectEnd = param1;
      }
      
      public function get OnBuffMouseMove() : Function
      {
         return this.FOnBuffMouseMove;
      }
      
      public function set OnBuffMouseMove(param1:Function) : void
      {
         this.FOnBuffMouseMove = param1;
      }
      
      public function get OnBuffMouseRollOut() : Function
      {
         return this.FOnBuffMouseRollOut;
      }
      
      public function set OnBuffMouseRollOut(param1:Function) : void
      {
         this.FOnBuffMouseRollOut = param1;
      }
      
      override public function ActivePlay(param1:int, param2:int = 0, param3:Vector.<TRole> = null, param4:Vector.<TTargetInfo> = null, param5:Function = null, param6:uint = 0, param7:Boolean = false) : void
      {
         var EndShake:Function;
         var EndDie:Function;
         var Index:uint = 0;
         var DeadSkillEffectId:uint = 0;
         var StampAnger:int = 0;
         var j:uint = 0;
         var Type:int = param1;
         var SkillId:int = param2;
         var Target:Vector.<TRole> = param3;
         var Results:Vector.<TTargetInfo> = param4;
         var Callback:Function = param5;
         var Time:uint = param6;
         var NoTextEffect:Boolean = param7;
         super.ActivePlay(Type,SkillId,Target,Results,Callback,Time);
         if(Type == TYPE_ACTIVE_DEADSKILL && Target != null)
         {
            if(this.FTextFunction != null)
            {
               this.FTextFunction(TBattleStage.TYPETEXT_Float,Camp == 0 ? -1 : 1,x,y - RoleHeight,0,false,CONST_BATTLE.TEXT_FIGHT_STATUS_DeadSkill);
            }
            Index = 0;
            while(Index < Target.length)
            {
               j = 0;
               while(j < Target.length)
               {
                  if(j > Index)
                  {
                     if(Results[Index].TargetPos == Results[j].TargetPos)
                     {
                        Results[Index].ResultInfo.HurtAnger += Results[j].ResultInfo.HurtAnger;
                        Results[Index].ResultInfo.HurtHp += Results[j].ResultInfo.HurtHp;
                        Results[j].ResultInfo.HurtAnger = 0;
                        Results[j].ResultInfo.HurtHp = 0;
                     }
                  }
                  j++;
               }
               Index++;
            }
            Index = 0;
            while(Index < Target.length)
            {
               if(Results[Index].CMD != TTargetInfo.CMD_NONE)
               {
                  if(Target[Index].Camp == Camp)
                  {
                     DeadSkillEffectId = uint(CONST_BATTLE.Public_Effect_DeadSkillEffect_Friend);
                  }
                  else
                  {
                     DeadSkillEffectId = uint(CONST_BATTLE.Public_Effect_DeadSkillEffect_Enemy);
                  }
                  Target[Index].AddEffect({
                     "target":2,
                     "effectId":DeadSkillEffectId,
                     "anmyhp":{
                        "1":100,
                        "checkDie":1
                     },
                     "friendhp":{"1":100}
                  },this,Vector.<TRole>([Target[Index]]),Vector.<TTargetInfo>([Results[Index]]));
               }
               if(Results[Index].ResultInfo.CMD == TTargetInfo.CMD_ATTACKEX)
               {
                  if(Results[Index].ResultInfo.HurtAnger > 0)
                  {
                     StampAnger = Math.min(Results[Index].ResultInfo.HurtAnger,Target[Index].CurAnger);
                  }
                  else
                  {
                     StampAnger = Results[Index].ResultInfo.HurtAnger;
                  }
                  Target[Index].AddAngerTextEffect(-StampAnger);
               }
               Target[Index].CurAnger -= Results[Index].ResultInfo.HurtAnger;
               Index++;
            }
            if(Callback != null)
            {
               Callback(Time);
            }
            return;
         }
         if(FIsDie)
         {
            if(Callback != null)
            {
               Callback(0);
            }
            return;
         }
         FSkillId = SkillId;
         FTargets = Target;
         FResults = Results;
         FSkilling = IsSkill(FSkillId);
         if(Type == TYPE_ACTIVE_FIGHT_IDLE)
         {
            PlayFightIdle();
            CheckDirection();
         }
         else if(Type == TYPE_ACTIVE_ATTACK)
         {
            this.DelStatus(CONST_BATTLE.TEXT_FIGHT_STATUS_OtherTurn,CONST_BATTLE.TEXT_FIGHT_STATUS_Punch);
            GetAttackEffect();
            FCallBackDict[TYPE_ACTIVE_ATTACK] = Callback;
            FTimeDict[TYPE_ACTIVE_ATTACK] = Time;
            PlayAttack();
         }
         else if(Type == TYPE_ACTIVE_ATTACKED)
         {
            FCallBackDict[TYPE_ACTIVE_ATTACKED] = Callback;
            FTimeDict[TYPE_ACTIVE_ATTACKED] = Time;
            PlayAttacked();
            SLogicsCore.SignalPost(CONST_SIGNAL.SIGNALDESTINATION_SOUND,CONST_MUSIC.PLAY_SOUND_EFFECT,SoundID,true);
         }
         else if(Type == TYPE_ACTIVE_SKILL)
         {
            GetAttackEffect();
            FCallBackDict[TYPE_ACTIVE_SKILL] = Callback;
            FTimeDict[TYPE_ACTIVE_SKILL] = Time;
            FSkillId = 0;
            this.PlayShowUI(SkillId);
         }
         else if(Type == TYPE_ACTIVE_DODGE)
         {
            EndShake = function():void
            {
               if(Callback != null)
               {
                  Callback(Time);
               }
            };
            if(!NoTextEffect)
            {
               TEffectControl.PlayShake(this,28,EndShake);
               FCallBackDict[TYPE_ACTIVE_DODGE] = Callback;
               FTimeDict[TYPE_ACTIVE_DODGE] = Time;
               if(this.FTextFunction != null)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Float,Camp == 0 ? -1 : 1,x,y - RoleHeight,0,false,CONST_BATTLE.TEXT_FIGHT_STATUS_Miss);
               }
            }
            else
            {
               EndShake();
            }
         }
         else if(Type == TYPE_ACTIVE_GRIDFILE)
         {
            if(this.FStatusGridFile)
            {
               return;
            }
            this.FStatusGridFile = true;
            FBitmap.visible = false;
            FCallBackDict[TYPE_ACTIVE_GRIDFILE] = Callback;
            FTimeDict[TYPE_ACTIVE_GRIDFILE] = Time;
            if(this.FTextFunction != null)
            {
               this.FTextFunction(TBattleStage.TYPETEXT_Float,Camp == 0 ? -1 : 1,x,y - RoleHeight,0,false,CONST_BATTLE.TEXT_FIGHT_STATUS_Counterattack);
            }
            TEffectControl.ShowPublicEffect(FEffectSprite,CONST_BATTLE.Public_Effect_Smoke,0,-70,this.ShowGridFile);
         }
         else if(Type == TYPE_ACTIVE_DIE)
         {
            EndDie = function():void
            {
               if(!FIsDie)
               {
                  return;
               }
               if(Callback != null)
               {
                  Callback(Time);
               }
            };
            FIsDie = true;
            FShaderBmp.visible = false;
            FHpBar.visible = false;
            FBuffSprite.visible = false;
            this.FHideFrame = 0;
            FBitmap.bitmapData = FBitmap.bitmapData.clone();
            FBitmap.filters = [TGameUtil.rBlackFilters];
            FCallBackDict[TYPE_ACTIVE_DIE] = Callback;
            FTimeDict[TYPE_ACTIVE_DIE] = Time;
            if(Camp == 0)
            {
               TweenUtil.to(this,1000,{
                  "x":this.x - 20,
                  "filters":[TGameUtil.ActiveDie],
                  "alpha":0,
                  "ease":Expo.easeOut,
                  "onComplete":EndDie
               });
            }
            else
            {
               TweenUtil.to(this,1000,{
                  "x":this.x + 20,
                  "filters":[TGameUtil.ActiveDie],
                  "alpha":0,
                  "ease":Expo.easeOut,
                  "onComplete":EndDie
               });
            }
         }
         else if(Type == TYPE_ACTIVE_RELIVE)
         {
            if(this.FTextFunction != null)
            {
               this.FTextFunction(TBattleStage.TYPETEXT_Float,Camp == 0 ? -1 : 1,x,y - RoleHeight,0,false,CONST_BATTLE.TEXT_FIGHT_STATUS_Relive);
               this.FTextFunction(TBattleStage.TYPETEXT_Float,Camp == 0 ? -1 : 1,x,y - RoleHeight,"+" + this.CurHealth);
            }
         }
         else if(Type == TYPE_ACTIVE_HURTHP)
         {
            if(this.FTextFunction != null)
            {
               this.FTextFunction(TBattleStage.TYPETEXT_Float,Camp == 0 ? -1 : 1,x,y - RoleHeight,"-" + Results[0].ResultInfo.HurtHp);
            }
         }
      }
      
      public function SetPosition(param1:Number, param2:Number) : void
      {
         FIdlePosition[0] = param1;
         FIdlePosition[1] = param2;
         this.x = param1;
         this.y = param2;
      }
      
      public function OnNextCommand(param1:int = 0) : void
      {
         if(this.FOnEffectEnd != null)
         {
            if(param1 > 0)
            {
               setTimeout(this.FOnEffectEnd,param1);
            }
            else
            {
               this.FOnEffectEnd();
            }
         }
      }
      
      public function CheckTextEffect(param1:TTargetInfo, param2:Vector.<TRole> = null) : void
      {
         var _loc3_:int = 0;
         var _loc4_:TRole = null;
         if(param1.TargetStatus & CONST_BATTLE.ActiveType_NoAddAnger)
         {
            param1.TargetStatus -= CONST_BATTLE.ActiveType_NoAddAnger;
            this.AddTextEffect(CONST_BATTLE.ActiveType_NoAddAnger);
         }
         if(param1.TargetStatus & CONST_BATTLE.ActiveType_NoSkill)
         {
            param1.TargetStatus -= CONST_BATTLE.ActiveType_NoSkill;
            this.AddTextEffect(CONST_BATTLE.ActiveType_NoSkill);
         }
         if(param1.TargetStatus & CONST_BATTLE.ActiveType_NoAddHp)
         {
            param1.TargetStatus -= CONST_BATTLE.ActiveType_NoAddHp;
            this.AddTextEffect(CONST_BATTLE.ActiveType_NoAddHp);
         }
         if(param1.TargetStatus & CONST_BATTLE.ActiveType_NoAttack)
         {
            param1.TargetStatus -= CONST_BATTLE.ActiveType_NoAttack;
            this.AddTextEffect(CONST_BATTLE.ActiveType_NoAttack);
         }
         if(param1.TargetStatus & CONST_BATTLE.ActiveType_BeStone)
         {
            param1.TargetStatus -= CONST_BATTLE.ActiveType_BeStone;
            this.AddTextEffect(CONST_BATTLE.ActiveType_BeStone);
         }
         if(param1.TargetStatus & CONST_BATTLE.ActiveType_Nothingness)
         {
            param1.TargetStatus -= CONST_BATTLE.ActiveType_Nothingness;
            this.AddTextEffect(CONST_BATTLE.ActiveType_Nothingness);
         }
         if(param1.TargetStatus & CONST_BATTLE.ActiveType_AllMiss)
         {
            param1.TargetStatus -= CONST_BATTLE.ActiveType_AllMiss;
            this.AddTextEffect(CONST_BATTLE.ActiveType_AllMiss);
         }
         if(param1.TargetStatus & CONST_BATTLE.ActiveType_Confusion)
         {
            param1.TargetStatus -= CONST_BATTLE.ActiveType_Confusion;
            this.AddTextEffect(CONST_BATTLE.ActiveType_Confusion);
         }
         if(param1.TargetStatus & CONST_BATTLE.ActiveType_ImmNoAnger)
         {
            param1.TargetStatus -= CONST_BATTLE.ActiveType_ImmNoAnger;
            this.AddTextEffect(CONST_BATTLE.ActiveType_ImmNoAnger);
         }
         if(param1.TargetStatus & CONST_BATTLE.ActiveType_ImmNoSkill)
         {
            param1.TargetStatus -= CONST_BATTLE.ActiveType_ImmNoSkill;
            this.AddTextEffect(CONST_BATTLE.ActiveType_ImmNoSkill);
         }
         if(param1.TargetStatus & CONST_BATTLE.ActiveType_ImmNoHeal)
         {
            param1.TargetStatus -= CONST_BATTLE.ActiveType_ImmNoHeal;
            this.AddTextEffect(CONST_BATTLE.ActiveType_ImmNoHeal);
         }
         if(param1.TargetStatus & CONST_BATTLE.ActiveType_ImmStone)
         {
            param1.TargetStatus -= CONST_BATTLE.ActiveType_ImmStone;
            this.AddTextEffect(CONST_BATTLE.ActiveType_ImmStone);
         }
         if(param1.TargetStatus & CONST_BATTLE.ActiveType_ImmFake)
         {
            param1.TargetStatus -= CONST_BATTLE.ActiveType_ImmFake;
            this.AddTextEffect(CONST_BATTLE.ActiveType_ImmFake);
         }
         if(param1.TargetStatus & CONST_BATTLE.ActiveType_ImmNoAttack)
         {
            param1.TargetStatus -= CONST_BATTLE.ActiveType_ImmNoAttack;
            this.AddTextEffect(CONST_BATTLE.ActiveType_ImmNoAttack);
         }
         if(param1.TargetStatus & CONST_BATTLE.ActiveType_ImmConfusion)
         {
            param1.TargetStatus -= CONST_BATTLE.ActiveType_ImmConfusion;
            this.AddTextEffect(CONST_BATTLE.ActiveType_ImmConfusion);
         }
         if(param1.TargetStatus & CONST_BATTLE.ActiveType_ImmAllMiss)
         {
            param1.TargetStatus -= CONST_BATTLE.ActiveType_ImmAllMiss;
            this.AddTextEffect(CONST_BATTLE.ActiveType_ImmAllMiss);
         }
         if(param1.TargetStatus & CONST_BATTLE.ActiveType_ImmCtrl)
         {
            param1.TargetStatus -= CONST_BATTLE.ActiveType_ImmCtrl;
            this.AddTextEffect(CONST_BATTLE.ActiveType_ImmCtrl);
         }
         if(param1.TargetStatus & CONST_BATTLE.ActiveType_ImmHitAcupoints)
         {
            param1.TargetStatus -= CONST_BATTLE.ActiveType_ImmHitAcupoints;
            this.AddTextEffect(CONST_BATTLE.ActiveType_ImmHitAcupoints);
         }
         if(param1.TargetStatus & CONST_BATTLE.ActiveType_ImmAwe)
         {
            param1.TargetStatus -= CONST_BATTLE.ActiveType_ImmAwe;
            this.AddTextEffect(CONST_BATTLE.ActiveType_ImmAwe);
         }
         if(param1.TargetStatus & CONST_BATTLE.ActiveType_ImmDead)
         {
            param1.TargetStatus -= CONST_BATTLE.ActiveType_ImmDead;
            this.AddTextEffect(CONST_BATTLE.ActiveType_ImmDead);
         }
         if(param1.TargetStatus1 & CONST_BATTLE.ActiveType_ImmCripple)
         {
            param1.TargetStatus1 -= CONST_BATTLE.ActiveType_ImmCripple;
            this.AddTextEffect(CONST_BATTLE.ActiveType_ImmCripple,"",1);
         }
         if(param1.TargetStatus1 & CONST_BATTLE.ActiveType_ImmExpel)
         {
            param1.TargetStatus1 -= CONST_BATTLE.ActiveType_ImmExpel;
            this.AddTextEffect(CONST_BATTLE.ActiveType_ImmExpel,"",1);
         }
         if(param1.TargetStatus1 & CONST_BATTLE.ActiveType_ImmParalysis)
         {
            param1.TargetStatus1 -= CONST_BATTLE.ActiveType_ImmParalysis;
            this.AddTextEffect(CONST_BATTLE.ActiveType_ImmParalysis,"",1);
         }
         if(param1.TargetStatus1 & CONST_BATTLE.ActiveType_ImmBlind)
         {
            param1.TargetStatus1 -= CONST_BATTLE.ActiveType_ImmBlind;
            this.AddTextEffect(CONST_BATTLE.ActiveType_ImmBlind,"",1);
         }
         if(param1.TargetStatus1 & CONST_BATTLE.ActiveType_ImmMoon)
         {
            param1.TargetStatus1 -= CONST_BATTLE.ActiveType_ImmMoon;
            this.AddTextEffect(CONST_BATTLE.ActiveType_ImmMoon,"",1);
         }
         if(param1.TargetStatus1 & CONST_BATTLE.ActiveType_ImmSeal)
         {
            param1.TargetStatus1 -= CONST_BATTLE.ActiveType_ImmSeal;
            this.AddTextEffect(CONST_BATTLE.ActiveType_ImmSeal,"",1);
         }
         if(param1.TargetStatus1 & CONST_BATTLE.ActiveType_ImmHolding)
         {
            param1.TargetStatus1 -= CONST_BATTLE.ActiveType_ImmHolding;
            this.AddTextEffect(CONST_BATTLE.ActiveType_ImmHolding,"",1);
         }
         if(param1.TargetStatus1 & CONST_BATTLE.ActiveType_ImmBengHuai)
         {
            param1.TargetStatus1 -= CONST_BATTLE.ActiveType_ImmBengHuai;
            this.AddTextEffect(CONST_BATTLE.ActiveType_ImmBengHuai,"",1);
         }
         if(param1.TargetStatus1 & CONST_BATTLE.ActiveType_ImmIce)
         {
            param1.TargetStatus1 -= CONST_BATTLE.ActiveType_ImmIce;
            this.AddTextEffect(CONST_BATTLE.ActiveType_ImmIce,"",1);
         }
         if(param1.TargetStatus1 & CONST_BATTLE.ActiveType_FastMiss)
         {
            param1.TargetStatus1 -= CONST_BATTLE.ActiveType_FastMiss;
            this.AddTextEffect(CONST_BATTLE.ActiveType_FastMiss,"",1);
         }
         if(param1.TargetStatus1 & CONST_BATTLE.ActiveType_ImmFastMiss)
         {
            param1.TargetStatus1 -= CONST_BATTLE.ActiveType_ImmFastMiss;
            this.AddTextEffect(CONST_BATTLE.ActiveType_ImmFastMiss,"",1);
         }
         if(param1.TargetStatus1 & CONST_BATTLE.ActiveType_CritExtra)
         {
            param1.TargetStatus1 -= CONST_BATTLE.ActiveType_CritExtra;
            this.AddTextEffect(CONST_BATTLE.ActiveType_CritExtra,"",1);
         }
         if(param1.TargetStatus1 & CONST_BATTLE.ActiveType_FengDun)
         {
            param1.TargetStatus1 -= CONST_BATTLE.ActiveType_FengDun;
            this.AddTextEffect(CONST_BATTLE.ActiveType_FengDun,"",1);
         }
         if(param1.TargetStatus1 & CONST_BATTLE.ActiveType_ImmFengFu)
         {
            param1.TargetStatus1 -= CONST_BATTLE.ActiveType_ImmFengFu;
            this.AddTextEffect(CONST_BATTLE.ActiveType_ImmFengFu,"",1);
         }
         if(param1.TargetStatus2 & CONST_BATTLE.ActiveType_ImmWeak)
         {
            param1.TargetStatus2 -= CONST_BATTLE.ActiveType_ImmWeak;
            this.AddTextEffect(CONST_BATTLE.ActiveType_ImmWeak,"",2);
         }
         if(param1.TargetStatus2 & CONST_BATTLE.ActiveType_ImmCharm)
         {
            param1.TargetStatus2 -= CONST_BATTLE.ActiveType_ImmCharm;
            this.AddTextEffect(CONST_BATTLE.ActiveType_ImmCharm,"",2);
         }
         if(param1.TargetStatus2 & CONST_BATTLE.ActiveType_ImmJiban)
         {
            param1.TargetStatus2 -= CONST_BATTLE.ActiveType_ImmJiban;
            this.AddTextEffect(CONST_BATTLE.ActiveType_ImmJiban,"",2);
         }
         if(param1.TargetStatus2 & CONST_BATTLE.ActiveType_ImmDownWind)
         {
            param1.TargetStatus2 -= CONST_BATTLE.ActiveType_ImmDownWind;
            this.AddTextEffect(CONST_BATTLE.ActiveType_ImmDownWind,"",2);
         }
         if(param1.TargetStatus2 & CONST_BATTLE.ActiveType_ImmUpWind)
         {
            param1.TargetStatus2 -= CONST_BATTLE.ActiveType_ImmUpWind;
            this.AddTextEffect(CONST_BATTLE.ActiveType_ImmUpWind,"",2);
         }
         if(param1.TargetStatus2 & CONST_BATTLE.ActiveType_ImmDuFeng)
         {
            param1.TargetStatus2 -= CONST_BATTLE.ActiveType_ImmDuFeng;
            this.AddTextEffect(CONST_BATTLE.ActiveType_ImmDuFeng,"",2);
         }
         if(param1.TargetStatus2 & CONST_BATTLE.ActiveType_ImmPoison)
         {
            param1.TargetStatus2 -= CONST_BATTLE.ActiveType_ImmPoison;
            this.AddTextEffect(CONST_BATTLE.ActiveType_ImmPoison,"",2);
         }
         if(param1.TargetStatus2 & CONST_BATTLE.ActiveType_ImmBurn)
         {
            param1.TargetStatus2 -= CONST_BATTLE.ActiveType_ImmBurn;
            this.AddTextEffect(CONST_BATTLE.ActiveType_ImmBurn,"",2);
         }
         if(param1.TargetStatus1 & CONST_BATTLE.ActiveType_Block)
         {
            param1.TargetStatus1 -= CONST_BATTLE.ActiveType_Block;
            this.FTextFunction(TBattleStage.TYPETEXT_Float,param1.TargetCamp == 0 ? -1 : 1,this.x,this.y - this.RoleHeight,int(param1.ResultInfo.HurtHp),false,CONST_BATTLE.TEXR_FIGHT_STATUS_BlocksPlus);
            _loc3_ = 0;
            while(_loc3_ < param2.length)
            {
               _loc4_ = param2[_loc3_] as TRole;
               if(_loc4_.Camp == param1.TargetCamp && _loc4_.Pos == param1.TargetPos)
               {
                  _loc4_.CurHealth -= param1.ResultInfo.HurtHp;
                  _loc4_.ActivePlay(TActive.TYPE_ACTIVE_ATTACKED,0,null,Vector.<TTargetInfo>([param1]));
                  break;
               }
               _loc3_++;
            }
         }
      }
      
      protected function GetBeiDongSkillName(param1:TRole) : String
      {
         var _loc2_:uint = 0;
         var _loc3_:THeroTalent = null;
         var _loc4_:TSkillConfig = null;
         var _loc5_:Object = null;
         var _loc6_:Array = null;
         var _loc7_:int = 0;
         if(param1.HeroData)
         {
            _loc2_ = uint(param1.HeroData.Talent);
         }
         else
         {
            _loc2_ = uint(param1.EnemyData.TalentId);
         }
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_HeroTalent,_loc2_) as THeroTalent;
         if(_loc3_)
         {
            _loc5_ = _loc3_.TalentEffectObject;
            if(_loc5_)
            {
               _loc6_ = _loc5_["talentEffect"];
               _loc7_ = 0;
               while(_loc7_ < _loc6_.length)
               {
                  _loc5_ = _loc6_[_loc7_];
                  if(_loc5_["tType"] == 201)
                  {
                     _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SkillConfig,_loc5_["tValue"]) as TSkillConfig;
                     return _loc4_.Name;
                  }
                  _loc7_++;
               }
            }
         }
         return "";
      }
      
      protected function GetNewTextBuffName(param1:int) : String
      {
         var _loc2_:TBuffEffect = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BuffEffect,param1) as TBuffEffect;
         if(_loc2_)
         {
            return _loc2_.Name;
         }
         return "";
      }
      
      public function PassiveSkillPlay(param1:Vector.<TRole>, param2:Vector.<TTargetInfo>, param3:uint) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:TTargetInfo = null;
         var _loc6_:TRole = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:Boolean = false;
         _loc11_ = 0;
         _loc12_ = false;
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc6_ = param1[_loc4_];
            _loc5_ = param2[_loc4_];
            _loc6_.CheckTextEffect(_loc5_);
            if(_loc5_.CMD == TTargetInfo.CMD_ATTRBUFF || _loc5_.CMD == TTargetInfo.CMD_HURTBUFF || _loc5_.CMD == TTargetInfo.CMD_CONTROLBUFF)
            {
               this.AddBuffs(this,param2);
               if(_loc6_.Camp == 0 || _loc6_.Camp == 1)
               {
                  _loc10_ = 13610302;
               }
               else if(param1[0].Camp == param1[1].Camp)
               {
                  _loc10_ = 13610301;
               }
               else
               {
                  _loc10_ = 13610302;
               }
               _loc6_.AddEffect({
                  "target":1,
                  "effectId":_loc10_
               },this,param1,param2);
               if(!_loc12_)
               {
                  param1[0].AddTextEffect(77777,this.GetBeiDongSkillName(param1[0]));
                  _loc12_ = true;
               }
            }
            else
            {
               _loc7_ = _loc5_.ResultInfo.HurtHp;
               _loc8_ = _loc5_.ResultInfo.HurtAnger;
               if(_loc6_.Camp == Camp)
               {
                  if(_loc7_ < 0)
                  {
                     _loc6_.AddEffect({
                        "target":2,
                        "effectId":CONST_BATTLE.Public_Effect_AddHp,
                        "friendhp":{"0":100}
                     },_loc6_,Vector.<TRole>([_loc6_]),Vector.<TTargetInfo>([_loc5_]),_loc6_.x,_loc6_.y,false);
                  }
                  else
                  {
                     this.FTextFunction(TBattleStage.TYPETEXT_Float,_loc6_.Camp == 0 ? -1 : 1,_loc6_.x,_loc6_.y - _loc6_.RoleHeight,String(int(_loc7_)),false);
                  }
                  _loc6_.CurHealth -= _loc7_;
                  _loc6_.CheckDie();
                  _loc6_.ActivePlay(TActive.TYPE_ACTIVE_ATTACKED,0,null,Vector.<TTargetInfo>([_loc5_]));
               }
               else if(_loc7_ != 0)
               {
                  if(this.FTextFunction != null)
                  {
                     if(_loc7_ < 0)
                     {
                        _loc6_.AddEffect({
                           "target":2,
                           "effectId":CONST_BATTLE.Public_Effect_AddHp,
                           "friendhp":{"0":100}
                        },_loc6_,Vector.<TRole>([_loc6_]),Vector.<TTargetInfo>([_loc5_]),_loc6_.x,_loc6_.y,false);
                     }
                     else
                     {
                        this.FTextFunction(TBattleStage.TYPETEXT_Float,_loc6_.Camp == 0 ? -1 : 1,_loc6_.x,_loc6_.y - _loc6_.RoleHeight,String(int(_loc7_)),false);
                     }
                  }
                  _loc6_.CurHealth -= _loc7_;
                  _loc6_.CheckDie();
                  _loc6_.ActivePlay(TActive.TYPE_ACTIVE_ATTACKED,0,null,Vector.<TTargetInfo>([_loc5_]));
               }
               if(_loc5_.CMD == TTargetInfo.CMD_ATTACKEX || _loc5_.CMD == TTargetInfo.CMD_ATTACK)
               {
                  if(_loc8_ >= 0)
                  {
                     _loc9_ = Math.min(_loc8_,_loc6_.CurAnger);
                  }
                  else
                  {
                     _loc9_ = _loc8_;
                  }
                  _loc6_.AddAngerTextEffect(-_loc9_);
                  _loc6_.CurAnger -= _loc8_;
                  if(_loc8_ >= 0)
                  {
                     _loc10_ = 13610302;
                  }
                  else
                  {
                     _loc10_ = 13610301;
                  }
                  _loc6_.AddEffect({
                     "target":1,
                     "effectId":_loc10_
                  },this,param1,param2);
                  if(!_loc12_)
                  {
                     param1[0].AddTextEffect(77777,this.GetBeiDongSkillName(param1[0]));
                     _loc12_ = true;
                  }
               }
            }
            _loc4_++;
         }
         this.OnNextCommand(param3);
      }
      
      public function NewTextBuffPlay(param1:Vector.<TRole>, param2:uint, param3:uint) : void
      {
         var _loc4_:int = 0;
         var _loc5_:TTargetInfo = null;
         var _loc6_:TRole = null;
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc6_ = param1[_loc4_];
            param1[0].AddTextEffect(77777,this.GetNewTextBuffName(param2));
            _loc4_++;
         }
         this.OnNextCommand(param3);
      }
      
      public function NewSkillPlay(param1:Vector.<TRole>, param2:Vector.<TTargetInfo>, param3:uint) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:TTargetInfo = null;
         var _loc6_:TRole = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         _loc11_ = 0;
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc6_ = param1[_loc4_];
            _loc5_ = param2[_loc4_];
            _loc10_ = 13610301;
            _loc6_.AddEffect({
               "target":1,
               "effectId":_loc10_
            },this,param1,param2);
            param1[0].AddTextEffect(77777,this.GetBeiDongSkillName(param1[0]));
            _loc4_++;
         }
         this.OnNextCommand(param3);
      }
      
      public function CommandPlay(param1:int, param2:Vector.<TRole>, param3:Vector.<TTargetInfo>, param4:uint) : void
      {
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         if(param1 == 0)
         {
            _loc6_ = param3.length;
            _loc5_ = 0;
            while(_loc5_ < _loc6_)
            {
               param2[_loc5_].CheckTextEffect(param3[_loc5_],param2);
               _loc5_++;
            }
            this.OnNextCommand(param4);
         }
         else
         {
            this.ActivePlay(ActiveType(param1),param1,param2,param3,this.OnNextCommand,param4);
         }
      }
      
      public function AddTextEffect(param1:int, param2:String = "", param3:int = 0) : void
      {
         var _loc4_:TGoneWord = null;
         if(this.FTextFunction != null)
         {
            if(param1 == 77777)
            {
               this.FTextFunction(TBattleStage.TYPETEXT_FloatCopy,-1,this.x,this.y - this.RoleHeight,param2);
               return;
            }
            if(param3 == 0)
            {
               if(param1 & CONST_BATTLE.ActiveType_Help)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Stand,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_Help);
               }
               if(param1 & CONST_BATTLE.ActiveType_Punch)
               {
                  if(param1 & CONST_BATTLE.ActiveType_Hit)
                  {
                     _loc4_ = this.FTextFunction(TBattleStage.TYPETEXT_Hold,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_OtherTurn);
                     this.DelStatus(CONST_BATTLE.TEXT_FIGHT_STATUS_OtherTurn);
                     this.FStatusGoneWordDict[CONST_BATTLE.TEXT_FIGHT_STATUS_OtherTurn] = _loc4_;
                  }
                  else
                  {
                     this.FTextFunction(TBattleStage.TYPETEXT_Float,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_OtherTurnLost);
                  }
               }
               if(param1 & CONST_BATTLE.ActiveType_ImmCtrl)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Stand,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_Lost);
               }
               if(param1 & CONST_BATTLE.ActiveType_ImmCalm)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Stand,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_Lost);
               }
               if(param1 & CONST_BATTLE.ActiveType_NoAddAnger)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Float,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_NoAddAnger);
               }
               if(param1 & CONST_BATTLE.ActiveType_NoSkill)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Float,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_NoSkill);
               }
               if(param1 & CONST_BATTLE.ActiveType_NoAddHp)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Float,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_NoAddHp);
               }
               if(param1 & CONST_BATTLE.ActiveType_NoAttack)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Float,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_NoAttack);
               }
               if(param1 & CONST_BATTLE.ActiveType_BeStone)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Float,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_BeStone);
               }
               if(param1 & CONST_BATTLE.ActiveType_Nothingness)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Float,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_Nothingness);
               }
               if(param1 & CONST_BATTLE.ActiveType_AllMiss)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Float,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_AllMiss);
               }
               if(param1 & CONST_BATTLE.ActiveType_Confusion)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Float,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_Confusion);
               }
               if(param1 & CONST_BATTLE.ActiveType_ImmNoAnger)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Float,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_ImmNoAnger);
               }
               if(param1 & CONST_BATTLE.ActiveType_ImmNoSkill)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Float,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_ImmNoSkill);
               }
               if(param1 & CONST_BATTLE.ActiveType_ImmNoHeal)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Float,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_ImmNoHeal);
               }
               if(param1 & CONST_BATTLE.ActiveType_ImmStone)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Float,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_ImmStone);
               }
               if(param1 & CONST_BATTLE.ActiveType_ImmFake)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Float,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_ImmFake);
               }
               if(param1 & CONST_BATTLE.ActiveType_ImmNoAttack)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Float,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_ImmNoAttack);
               }
               if(param1 & CONST_BATTLE.ActiveType_ImmConfusion)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Float,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_ImmConfusion);
               }
               if(param1 & CONST_BATTLE.ActiveType_ImmAllMiss)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Float,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_ImmAllMiss);
               }
               if(param1 & CONST_BATTLE.ActiveType_ImmHitAcupoints)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Float,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_ImmHitAcupoints);
               }
               if(param1 & CONST_BATTLE.ActiveType_ImmAwe)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Float,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_ImmAwe);
               }
               if(param1 & CONST_BATTLE.ActiveType_ImmDead)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Float,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_ImmDead);
               }
            }
            if(param3 == 1)
            {
               if(param1 & CONST_BATTLE.ActiveType_ImmCripple)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Float,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_ImmCripple1);
               }
               if(param1 & CONST_BATTLE.ActiveType_ImmExpel)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Float,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_ImmExpel);
               }
               if(param1 & CONST_BATTLE.ActiveType_ImmParalysis)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Float,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_ImmParalysis);
               }
               if(param1 & CONST_BATTLE.ActiveType_ImmBlind)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Float,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_ImmBlind);
               }
               if(param1 & CONST_BATTLE.ActiveType_ImmMoon)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Float,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_ImmMoon);
               }
               if(param1 & CONST_BATTLE.ActiveType_ImmSeal)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Float,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_ImmSeal);
               }
               if(param1 & CONST_BATTLE.ActiveType_ImmHolding)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Float,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_ImmHolding);
               }
               if(param1 & CONST_BATTLE.ActiveType_ImmBengHuai)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Float,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_ImmBengHuai);
               }
               if(param1 & CONST_BATTLE.ActiveType_ImmIce)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Float,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_ImmIce);
               }
               if(param1 & CONST_BATTLE.ActiveType_FastMiss)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Float,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_FastMiss);
               }
               if(param1 & CONST_BATTLE.ActiveType_ImmFastMiss)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Float,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_ImmFastMiss);
               }
               if(param1 & CONST_BATTLE.ActiveType_CritExtra)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Float,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_CritExtra);
               }
               if(param1 & CONST_BATTLE.ActiveType_FengDun)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Float,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_FengDun);
               }
               if(param1 & CONST_BATTLE.ActiveType_ImmFengFu)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Float,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_ImmFengFu);
               }
            }
            if(param3 == 2)
            {
               if(param1 & CONST_BATTLE.ActiveType_ImmWeak)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Float,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_ImmWeak);
               }
               if(param1 & CONST_BATTLE.ActiveType_ImmCharm)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Float,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_ImmCharm);
               }
               if(param1 & CONST_BATTLE.ActiveType_ImmJiban)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Float,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_ImmJiban);
               }
               if(param1 & CONST_BATTLE.ActiveType_ImmDownWind)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Float,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_ImmDownWind);
               }
               if(param1 & CONST_BATTLE.ActiveType_ImmUpWind)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Float,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_ImmUpWind);
               }
               if(param1 & CONST_BATTLE.ActiveType_ImmDuFeng)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Float,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_ImmDuFeng);
               }
               if(param1 & CONST_BATTLE.ActiveType_ImmPoison)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Float,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_ImmPoison);
               }
               if(param1 & CONST_BATTLE.ActiveType_ImmBurn)
               {
                  this.FTextFunction(TBattleStage.TYPETEXT_Float,0,this.x,this.y - this.RoleHeight,"0",false,CONST_BATTLE.TEXT_FIGHT_STATUS_ImmBurn);
               }
            }
         }
      }
      
      public function AddAngerTextEffect(param1:int) : void
      {
         if(this.FTextFunction != null && param1 != 0)
         {
            this.FTextFunction(TBattleStage.TYPETEXT_UpNumber,Camp == 0 ? -1 : 1,x - 50,y - RoleHeight - 50,(param1 > 0 ? "+" : "") + param1,false,0,param1 > 0 ? 4278309631 : 4290728191,param1 > 0 ? 4278265408 : 4281008199);
         }
      }
      
      public function AddEffect(param1:Object, param2:TRole, param3:Vector.<TRole> = null, param4:Vector.<TTargetInfo> = null, param5:Number = 0, param6:Number = 0, param7:Boolean = true) : void
      {
         TEffectControl.ShowEffect(this,param1.effectId,param1,param2,this,param3,param4,param5,param6,0,0,this.FTextFunction,0,0,0,1,-1,param7);
      }
      
      override public function UpdateActive() : void
      {
         var _loc1_:Object = null;
         var _loc2_:Object = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TAnimationFrame = null;
         var _loc6_:TAnimationSequence = null;
         var _loc7_:BitmapData = null;
         var _loc8_:TRole = null;
         var _loc9_:TSkillEffectConfig = null;
         var _loc10_:Class = null;
         var _loc11_:int = 0;
         var _loc12_:Object = null;
         var _loc13_:Number = NaN;
         var _loc14_:Boolean = false;
         var _loc15_:Boolean = false;
         var _loc16_:Vector.<TRole> = null;
         var _loc17_:Vector.<TTargetInfo> = null;
         var _loc18_:Object = null;
         var _loc19_:Number = NaN;
         var _loc20_:int = 0;
         if(stage == null)
         {
            return;
         }
         if(FIsDie)
         {
            return;
         }
         if(FIsAntiColorBlackWhite || FIsRedAntiColor)
         {
            return;
         }
         if(FShaderBmp.bitmapData == null)
         {
            TGameUtil.ShowEffectById(FShaderBmp,CONST_BATTLE.Public_Effect_Shadow);
         }
         if(FTexture != null)
         {
            if(FTexture.Count == 0)
            {
               FTexture = null;
            }
         }
         if(FTexture == null)
         {
            FTexture = SResourcesCore.TexturesModel.GetTextureByIdentifier(FResourcesId);
            if(FTexture == null)
            {
               SResourcesCore.TexturesModel.LoadSecondary(FResourcesId,FModelId);
               if(FDemoPeople)
               {
                  FDemoPeople.visible = true;
               }
               else
               {
                  FDemoPeople = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_DefaultRoleTexture) as MovieClip;
                  addChild(FDemoPeople);
               }
            }
         }
         if(FTexture != null)
         {
            _loc6_ = FTexture.GetAnimationSequenceByIndex(FIndex);
            if(_loc6_ != null)
            {
               _loc5_ = _loc6_.GetAnimationFrameByTick(FTickReference);
               if(SoulFormationID > 0)
               {
                  for each(_loc12_ in FAttackEffect)
                  {
                     if(_loc12_[FSkillId] != null)
                     {
                        _loc1_ = _loc12_[FSkillId];
                        break;
                     }
                  }
               }
               else
               {
                  _loc1_ = FAttackEffect[FSkillId];
               }
               if(_loc1_ != null)
               {
                  if(_loc1_.appendEffect != null)
                  {
                     _loc2_ = _loc1_.appendEffect[_loc6_.Index];
                     if(_loc2_ != null)
                     {
                        if(_loc2_.target == 1)
                        {
                           this.AddEffect(_loc2_,this,FTargets,FResults,FBitmap.x,FBitmap.y);
                        }
                        else if(_loc2_.target == 2)
                        {
                           if(FTargets != null)
                           {
                              _loc3_ = 0;
                              for(; _loc3_ < FTargets.length; _loc3_++)
                              {
                                 if(this == FTargets[_loc3_])
                                 {
                                    if(FSkilling)
                                    {
                                       if(FResults[_loc3_].ResultInfo.HurtAnger > 0)
                                       {
                                          continue;
                                       }
                                    }
                                    else if(FResults[_loc3_].ResultInfo.HurtAnger < 0)
                                    {
                                       continue;
                                    }
                                 }
                                 if(CONST_BATTLE.HasEnemy(FTargets,Camp))
                                 {
                                    if(FTargets[_loc3_].Camp != Camp)
                                    {
                                       FTargets[_loc3_].AddEffect(TEffectControl.CopyObject(_loc2_),this,Vector.<TRole>([FTargets[_loc3_]]),Vector.<TTargetInfo>([FResults[_loc3_]]),FBitmap.x,FBitmap.y,false);
                                       if(FResults[_loc3_].ResultInfo.HurtAnger > 0)
                                       {
                                          FTargets[_loc3_].AddEffect({
                                             "target":2,
                                             "effectId":CONST_BATTLE.Public_Effect_DecAngle
                                          },this,Vector.<TRole>([FTargets[_loc3_]]),Vector.<TTargetInfo>([FResults[_loc3_]]),FBitmap.x,FBitmap.y,false);
                                       }
                                    }
                                    else if(FResults[_loc3_].ResultInfo.HurtAnger < 0 && FResults[_loc3_].AngerGaining < 100)
                                    {
                                       FTargets[_loc3_].AddEffect({
                                          "target":2,
                                          "effectId":CONST_BATTLE.Public_Effect_AddAngle
                                       },this,Vector.<TRole>([FTargets[_loc3_]]),Vector.<TTargetInfo>([FResults[_loc3_]]),FBitmap.x,FBitmap.y,false);
                                       FResults[_loc3_].AngerGaining = 100;
                                    }
                                 }
                                 else
                                 {
                                    FTargets[_loc3_].AddEffect(TEffectControl.CopyObject(_loc2_),this,Vector.<TRole>([FTargets[_loc3_]]),Vector.<TTargetInfo>([FResults[_loc3_]]),FBitmap.x,FBitmap.y,false);
                                 }
                              }
                           }
                        }
                        else if(_loc2_.target == 3)
                        {
                           TEffectControl.ShowEffect(Parent,_loc2_.effectId,_loc2_,this,this,FTargets,FResults,0,0,this.x,this.y,null,0,0,0,Camp == 0 ? 1 : -1,Parent.getChildIndex(this));
                        }
                        else if(_loc2_.target == 4)
                        {
                           if(Camp == 0)
                           {
                              TEffectControl.ShowEffect(this.FBattleStage,_loc2_.effectId,_loc2_,this,this,FTargets,FResults,0,0,CONST_COMMON.STAGE_Width,0,this.FTextFunction,0,0,0,-1);
                           }
                           else
                           {
                              TEffectControl.ShowEffect(this.FBattleStage,_loc2_.effectId,_loc2_,this,this,FTargets,FResults,0,0,0,0,this.FTextFunction,0,0,0,1);
                           }
                        }
                        else if(_loc2_.target == 5)
                        {
                           if(Camp == 0)
                           {
                              TEffectControl.ShowEffect(this.FBattleStage,_loc2_.effectId,_loc2_,this,this,FTargets,FResults,0,0,0,0,this.FTextFunction,0,0,0,-1);
                           }
                           else
                           {
                              TEffectControl.ShowEffect(this.FBattleStage,_loc2_.effectId,_loc2_,this,this,FTargets,FResults,0,0,CONST_COMMON.STAGE_Width,0,this.FTextFunction);
                           }
                        }
                        else if(_loc2_.target == 7)
                        {
                           if(FTargets != null)
                           {
                              _loc3_ = 0;
                              for(; _loc3_ < FTargets.length; _loc3_++)
                              {
                                 if(this == FTargets[_loc3_])
                                 {
                                    if(int(FResults[_loc3_].ResultInfo.HurtHp) == 0)
                                    {
                                       continue;
                                    }
                                 }
                                 if(FTargets[_loc3_].Camp == Camp)
                                 {
                                    FTargets[_loc3_].AddEffect(_loc2_,this,FTargets,FResults,FBitmap.x,FBitmap.y);
                                 }
                              }
                           }
                        }
                        else if(_loc2_.target == 8)
                        {
                           this.BattleStage.ShowWhiteSprite();
                        }
                        else if(_loc2_.target == 9)
                        {
                           if(Camp == 0)
                           {
                              TEffectControl.ShowEffect(this.FBattleStage,_loc2_.effectId,_loc2_,this,this,FTargets,FResults,0,0,CONST_COMMON.STAGE_Width / 2,CONST_COMMON.STAGE_Height / 3 * 2,this.FTextFunction,40,0,600);
                           }
                           else
                           {
                              TEffectControl.ShowEffect(this.FBattleStage,_loc2_.effectId,_loc2_,this,this,FTargets,FResults,0,0,CONST_COMMON.STAGE_Width / 2,CONST_COMMON.STAGE_Height / 3 * 2,this.FTextFunction,-40,0,600);
                           }
                        }
                        else if(_loc2_.target == 10)
                        {
                           TEffectControl.ShowEffect(this.FBattleStage,_loc2_.effectId,_loc2_,this,this,FTargets,FResults,0,0,this.x,this.y,this.FTextFunction,0,0,0,this.Camp == 0 ? 1 : -1);
                        }
                        else if(_loc2_.target == 11)
                        {
                           if(Camp == 0)
                           {
                              TEffectControl.ShowEffect(this.FBattleStage,_loc2_.effectId,_loc2_,this,this,FTargets,FResults,0,0,SBattleConfig.GetPostionByCamyPos(1,6,SBattleConfig.Type_PostionX),SBattleConfig.GetPostionByCamyPos(1,6,SBattleConfig.Type_PostionY),this.FTextFunction,0,0,0,-1);
                           }
                           else
                           {
                              TEffectControl.ShowEffect(this.FBattleStage,_loc2_.effectId,_loc2_,this,this,FTargets,FResults,0,0,SBattleConfig.GetPostionByCamyPos(0,6,SBattleConfig.Type_PostionX),SBattleConfig.GetPostionByCamyPos(0,6,SBattleConfig.Type_PostionY),this.FTextFunction,0,0,0,1);
                           }
                        }
                        else if(_loc2_.target == 12)
                        {
                           if(FTargets != null)
                           {
                              _loc16_ = new Vector.<TRole>();
                              _loc17_ = new Vector.<TTargetInfo>();
                              _loc16_.push(this);
                              _loc3_ = 0;
                              while(_loc3_ < FTargets.length)
                              {
                                 if(FResults[_loc3_].TargetStatus & CONST_BATTLE.ActiveType_TargetEffect)
                                 {
                                    FResults[_loc3_].TargetStatus -= CONST_BATTLE.ActiveType_TargetEffect;
                                    _loc16_.push(FTargets[_loc3_]);
                                    _loc17_.push(FResults[_loc3_]);
                                 }
                                 _loc3_++;
                              }
                              if(_loc16_.length >= 2)
                              {
                                 TEffectControl.ShowSpecialChainEffect(this.FBattleStage,_loc2_.effectId,_loc2_,_loc16_,_loc17_,this.FTextFunction);
                              }
                           }
                        }
                        if(SoulFormationID > 0)
                        {
                           _loc11_ = 0;
                           for each(_loc18_ in FAttackEffect)
                           {
                              if(_loc18_[FSkillId] != null)
                              {
                                 FAttackEffect[_loc11_][FSkillId].appendEffect[_loc6_.Index] = null;
                                 break;
                              }
                              _loc11_++;
                           }
                        }
                        else
                        {
                           FAttackEffect[FSkillId].appendEffect[_loc6_.Index] = null;
                        }
                     }
                  }
                  if(_loc1_.blackwhite)
                  {
                     if(_loc1_.blackwhite[_loc6_.Index] != null)
                     {
                        this.FBattleStage.AntiColorBlackWhite(this,Boolean(_loc1_.blackwhite[_loc6_.Index]));
                     }
                  }
                  if(_loc1_.red)
                  {
                     if(_loc1_.red[_loc6_.Index] != null)
                     {
                        this.FBattleStage.RedAntiColor(this,Boolean(_loc1_.red[_loc6_.Index]));
                     }
                  }
                  if(_loc1_.ChgBg)
                  {
                     if(_loc1_.ChgBg[_loc6_.Index] != null)
                     {
                        this.FBattleStage.ChangeBg(this,_loc1_.ChgBg[_loc6_.Index]);
                     }
                  }
                  if(_loc1_.FullScreenGradient)
                  {
                     if(_loc1_.FullScreenGradient[_loc6_.Index] != null)
                     {
                        this.FBattleStage.FullScreenGradient(this,uint(_loc1_.FullScreenGradient[_loc6_.Index].color),_loc1_.FullScreenGradient[_loc6_.Index].time);
                        _loc1_.FullScreenGradient[_loc6_.Index] = null;
                     }
                  }
                  if(_loc1_.voice != null)
                  {
                     if(_loc1_.voice[_loc6_.Index] != null)
                     {
                        SLogicsCore.SignalPost(CONST_SIGNAL.SIGNALDESTINATION_SOUND,CONST_MUSIC.PLAY_SOUND_EFFECT,_loc1_.voice[_loc6_.Index],true);
                        _loc1_.voice[_loc6_.Index] = null;
                     }
                  }
                  if(FTargets != null)
                  {
                     _loc3_ = 0;
                     while(_loc3_ < FTargets.length)
                     {
                        _loc8_ = FTargets[_loc3_];
                        _loc14_ = Boolean((FResults[_loc3_].TargetStatus & CONST_BATTLE.ActiveType_Crit) != 0);
                        _loc15_ = Boolean((FResults[_loc3_].TargetStatus1 & CONST_BATTLE.ActiveType_Penetrate) != 0);
                        _loc8_.CheckTextEffect(FResults[_loc3_]);
                        if(_loc8_.Camp == Camp)
                        {
                           if(Boolean(_loc1_.friendhp) && Boolean(_loc1_.friendhp[_loc6_.Index] != null) && FResults[_loc3_].HealthGaining < 100)
                           {
                              _loc13_ = FResults[_loc3_].ResultInfo.HurtHp * _loc1_.friendhp[_loc6_.Index] / 100;
                              _loc8_.CurHealth -= _loc13_;
                              if(_loc13_ != 0)
                              {
                                 FResults[_loc3_].HealthGaining += _loc1_.friendhp[_loc6_.Index];
                              }
                              if(this.FTextFunction != null)
                              {
                                 this.FTextFunction(TBattleStage.TYPETEXT_Float,_loc8_.Camp == 0 ? -1 : 1,_loc8_.x,_loc8_.y - _loc8_.RoleHeight,"+" + int(Math.abs(_loc13_)),_loc14_,0,16777215,0,_loc15_);
                              }
                           }
                        }
                        else if(Boolean(_loc1_.anmyhp) && _loc1_.anmyhp[_loc6_.Index] != null)
                        {
                           _loc13_ = FResults[_loc3_].ResultInfo.HurtHp * _loc1_.anmyhp[_loc6_.Index] / 100;
                           if(FResults[_loc3_].TargetStatus & CONST_BATTLE.ActiveType_Hit)
                           {
                              if(FResults[_loc3_].TargetStatus & CONST_BATTLE.ActiveType_Help)
                              {
                                 FResults[_loc3_].TargetStatus -= CONST_BATTLE.ActiveType_Help;
                                 _loc8_.AddTextEffect(CONST_BATTLE.ActiveType_Help);
                              }
                              if(FResults[_loc3_].TargetStatus & CONST_BATTLE.ActiveType_ImmCtrl)
                              {
                                 FResults[_loc3_].TargetStatus -= CONST_BATTLE.ActiveType_ImmCtrl;
                                 _loc8_.AddTextEffect(CONST_BATTLE.ActiveType_ImmCtrl);
                              }
                              if(FResults[_loc3_].TargetStatus & CONST_BATTLE.ActiveType_ImmCalm)
                              {
                                 FResults[_loc3_].TargetStatus -= CONST_BATTLE.ActiveType_ImmCalm;
                                 _loc8_.AddTextEffect(CONST_BATTLE.ActiveType_ImmCalm);
                              }
                              if(_loc13_ != 0)
                              {
                                 _loc8_.CurHealth -= _loc13_;
                                 _loc8_.ActivePlay(TActive.TYPE_ACTIVE_ATTACKED,0,null,Vector.<TTargetInfo>([FResults[_loc3_]]));
                                 if(FResults[_loc3_].TargetStatus & CONST_BATTLE.ActiveType_Block)
                                 {
                                    TEffectControl.ShowPublicEffect(_loc8_,CONST_BATTLE.Public_Effect_Smoke,0,0);
                                 }
                                 if(this.FTextFunction != null)
                                 {
                                    this.FTextFunction(TBattleStage.TYPETEXT_Float,_loc8_.Camp == 0 ? -1 : 1,_loc8_.x,_loc8_.y - _loc8_.RoleHeight,String(int(_loc13_)),_loc14_,FResults[_loc3_].TargetStatus & CONST_BATTLE.ActiveType_Block ? CONST_BATTLE.TEXT_FIGHT_STATUS_Block : 0);
                                 }
                              }
                              if(Boolean(_loc1_.anmyhp.checkDie) && !(FResults[_loc3_].TargetStatus & CONST_BATTLE.ActiveType_Block))
                              {
                                 _loc8_.CheckDie();
                              }
                           }
                           else if(Boolean(FResults[_loc3_].TargetStatus & CONST_BATTLE.ActiveType_ImmCtrl) || Boolean(FResults[_loc3_].TargetStatus & CONST_BATTLE.ActiveType_ImmCalm))
                           {
                              if(this.FTextFunction != null)
                              {
                                 this.FTextFunction(TBattleStage.TYPETEXT_Float,_loc8_.Camp == 0 ? -1 : 1,_loc8_.x,_loc8_.y - _loc8_.RoleHeight,0,false,CONST_BATTLE.TEXT_FIGHT_STATUS_Lost);
                              }
                           }
                           else if(!(FResults[_loc3_].TargetStatus & CONST_BATTLE.ActiveType_Punch))
                           {
                              _loc8_.ActivePlay(TActive.TYPE_ACTIVE_DODGE,0,null,null,null,0,Boolean(FResults[_loc3_].CMD == 0));
                           }
                           if(this.FBattleStage.IsCrit)
                           {
                              this.FBattleStage.IsCrit = false;
                              this.FBattleStage.CriticalUI();
                           }
                        }
                        _loc3_++;
                     }
                  }
                  if(Boolean(_loc1_.anmyhp) && _loc1_.anmyhp[_loc6_.Index] != null)
                  {
                     _loc1_.anmyhp[_loc6_.Index] = null;
                  }
                  if(Boolean(_loc1_.friendhp) && _loc1_.friendhp[_loc6_.Index] != null)
                  {
                     _loc1_.friendhp[_loc6_.Index] = null;
                  }
               }
               if(_loc5_ == null)
               {
                  this.FActiveCallBack = FCallBackDict[FIndex];
                  this.FActiveTime = FTimeDict[FIndex];
                  if(FIsInFight)
                  {
                     FIndex = TYPE_ACTIVE_FIGHT_IDLE;
                  }
                  else
                  {
                     FIndex = TYPE_ACTIVE_IDLE;
                  }
                  if(FTargets != null)
                  {
                     _loc3_ = 0;
                     for(; _loc3_ < FTargets.length; _loc3_++)
                     {
                        if(this == FTargets[_loc3_])
                        {
                           if(FSkilling)
                           {
                              if(FResults[_loc3_].ResultInfo.HurtAnger > 0)
                              {
                                 continue;
                              }
                           }
                           else if(FResults[_loc3_].ResultInfo.HurtAnger < 0)
                           {
                              continue;
                           }
                        }
                        if(CONST_BATTLE.HasEnemy(FTargets,Camp))
                        {
                           if(FTargets[_loc3_].Camp == Camp)
                           {
                              if(FResults[_loc3_].ResultInfo.HurtHp < 0 && FResults[_loc3_].HealthGaining < 100)
                              {
                                 FTargets[_loc3_].AddEffect({
                                    "target":2,
                                    "effectId":CONST_BATTLE.Public_Effect_AddHp,
                                    "friendhp":{"0":100}
                                 },this,Vector.<TRole>([FTargets[_loc3_]]),Vector.<TTargetInfo>([FResults[_loc3_]]),FBitmap.x,FBitmap.y,false);
                              }
                           }
                        }
                     }
                  }
                  if(FIdlePosition != null)
                  {
                     this.x = FIdlePosition[0];
                     this.y = FIdlePosition[1];
                  }
                  FSkillId = 0;
                  this.FWaitNextCommand = true;
               }
               else
               {
                  _loc7_ = _loc5_.Surface;
                  if(FBitmap.bitmapData != _loc7_)
                  {
                     FBitmap.bitmapData = _loc7_;
                     FBitmap.x = -_loc5_.Pivot.X;
                     FBitmap.y = -_loc5_.Pivot.Y;
                     if(!FInitHpBarHeight)
                     {
                        FInitHpBarHeight = true;
                        FHpBar.y = -_loc5_.Pivot.Y - 8;
                        FWuxingBmp.y = FWuxingBmp1.y = FHpBar.y + FHpBar.mc_name.y - 20;
                        FWuxingBmp.x = FHpBar.x + FHpBar.mc_name.x - FWuxingBmp.width - 35;
                        FWuxingBmp1.x = FWuxingBmp.x - FWuxingBmp.width;
                     }
                     if(this.FHideFrame >= 0 && this.FHideFrame != _loc6_.Index)
                     {
                        this.FHideFrame = -1;
                        FShaderBmp.visible = true;
                        FHpBar.visible = true;
                        FBuffSprite.visible = true;
                     }
                     if(FAttackEffect[FSkillId] != null && FAttackEffect[FSkillId].newPoint != null)
                     {
                        _loc2_ = FAttackEffect[FSkillId].newPoint[_loc6_.Index];
                        if(_loc2_ != null)
                        {
                           if(_loc2_.target == 2)
                           {
                              _loc19_ = Camp == 0 ? -100 : 100;
                              this.x = _loc2_.newPointX ? Number(_loc2_.newPointX) : CONST_BATTLE.AverageX(FTargets,Camp) + _loc19_;
                              this.y = _loc2_.newPointY ? Number(_loc2_.newPointY) : CONST_BATTLE.AverageY(FTargets,Camp);
                              this.FHideFrame = _loc6_.Index;
                              FShaderBmp.visible = false;
                              FHpBar.visible = false;
                              FBuffSprite.visible = false;
                              FAttackEffect[FSkillId].newPoint[_loc6_.Index] = null;
                           }
                        }
                     }
                     if(FAttackEffect[FSkillId] != null && FAttackEffect[FSkillId].runPoint != null)
                     {
                        _loc2_ = FAttackEffect[FSkillId].runPoint[_loc6_.Index];
                        if(_loc2_ != null)
                        {
                           _loc19_ = Camp == 0 ? -100 : 100;
                           TweenUtil.to(this,200,{
                              "PosX":CONST_BATTLE.AverageX(FTargets,Camp) + _loc19_,
                              "PosY":CONST_BATTLE.AverageY(FTargets,Camp)
                           });
                           FAttackEffect[FSkillId].runPoint[_loc6_.Index] = null;
                        }
                     }
                     if(FAttackEffect[FSkillId] != null && FAttackEffect[FSkillId].backPoint != null)
                     {
                        _loc2_ = FAttackEffect[FSkillId].backPoint[_loc6_.Index];
                        if(_loc2_ != null)
                        {
                           this.FightMoveBack();
                           FAttackEffect[FSkillId].backPoint[_loc6_.Index] = null;
                        }
                     }
                  }
               }
               if(FWaitDie)
               {
                  if(FIndex == TYPE_ACTIVE_ATTACKED && _loc5_ == null || FIndex != TYPE_ACTIVE_ATTACKED)
                  {
                     FWaitDie = false;
                     this.ActivePlay(TActive.TYPE_ACTIVE_DIE);
                  }
               }
               if(this.FWaitNextCommand)
               {
                  if(TEffectControl.EffectCount <= 0)
                  {
                     this.FWaitNextCommand = false;
                     if(FTargets != null)
                     {
                        _loc3_ = 0;
                        while(_loc3_ < FTargets.length)
                        {
                           if(FResults[_loc3_].ResultInfo.CMD == TTargetInfo.CMD_ATTACKEX)
                           {
                              if(FResults[_loc3_].ResultInfo.HurtAnger > 0)
                              {
                                 _loc20_ = Math.min(FResults[_loc3_].ResultInfo.HurtAnger,FTargets[_loc3_].CurAnger);
                              }
                              else
                              {
                                 _loc20_ = FResults[_loc3_].ResultInfo.HurtAnger;
                              }
                              FTargets[_loc3_].AddAngerTextEffect(-_loc20_);
                           }
                           FTargets[_loc3_].CurAnger -= FResults[_loc3_].ResultInfo.HurtAnger;
                           _loc3_++;
                        }
                     }
                     if(this.FActiveCallBack != null)
                     {
                        this.FActiveCallBack(this.FActiveTime);
                     }
                  }
               }
               FTickReference += 1000 / stage.frameRate;
            }
            if(FDemoPeople != null)
            {
               FBitmap.visible = true;
               FDemoPeople.visible = false;
               CheckDirection();
            }
         }
      }
      
      public function AddBuffs(param1:TRole, param2:Vector.<TTargetInfo>) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Vector.<int> = null;
         var _loc7_:int = 0;
         var _loc8_:uint = 0;
         var _loc9_:Sprite = null;
         var _loc10_:int = 0;
         var _loc11_:Boolean = false;
         var _loc12_:Vector.<int> = null;
         if(param2 == null)
         {
            return;
         }
         _loc12_ = new Vector.<int>();
         _loc3_ = 0;
         for(; _loc3_ < param2.length; _loc3_++)
         {
            if(param2[_loc3_].TargetCamp == Camp && param2[_loc3_].TargetPos == Pos)
            {
               _loc7_ = param2[_loc3_].ResultInfo.BuffId;
               _loc8_ = uint(param2[_loc3_].ResultInfo.BuffTurn);
               _loc11_ = false;
               if(_loc7_ > 0 && _loc8_ != 0)
               {
                  _loc6_ = this.GetSameBuffIndex(this.FBuffIdVect,_loc7_);
                  if(_loc6_.length <= 1)
                  {
                     this.FBuffIdVect.push(_loc7_);
                     this.FBuffTurnVect.push(_loc8_);
                     _loc9_ = TPoolBitmap.GetBitmapSprite();
                     _loc9_.addEventListener(MouseEvent.MOUSE_MOVE,this.OnMouseMove);
                     _loc9_.addEventListener(MouseEvent.ROLL_OUT,this.OnRollOut);
                     _loc9_.mouseEnabled = true;
                     FBuffSprite.addChild(_loc9_);
                     this.FBuffSpriteVect.push(_loc9_);
                     this.FIsNewBuffVect.push(Boolean(param1 == this));
                     continue;
                  }
                  _loc10_ = _loc6_[0];
                  _loc4_ = 0;
                  while(_loc4_ < _loc6_.length - 1)
                  {
                     _loc5_ = _loc6_[1 + _loc4_];
                     if(_loc10_ >= _loc6_[1 + _loc4_ + 1])
                     {
                        if(!_loc11_)
                        {
                           _loc11_ = true;
                           this.FBuffIdVect[_loc5_] = _loc7_;
                           this.FBuffTurnVect[_loc5_] = _loc8_;
                           this.FIsNewBuffVect[_loc5_] = Boolean(param1 == this);
                        }
                        else
                        {
                           _loc12_.push(_loc5_);
                        }
                     }
                     _loc4_ += 2;
                  }
               }
               else
               {
                  this.DelSameTypeBuffIndex(_loc8_);
               }
            }
            this.CheckTextEffect(param2[_loc3_]);
         }
         _loc3_ = 0;
         while(_loc3_ < _loc12_.length)
         {
            _loc5_ = _loc12_[_loc3_];
            this.DelBuffs(this.FBuffIdVect[_loc5_]);
            _loc3_++;
         }
      }
      
      public function CheckBuffsHurt(param1:Vector.<TTargetInfo>) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TTargetInfo = null;
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _loc4_ = param1[_loc2_];
            _loc3_ = this.FBuffIdVect.indexOf(_loc4_.ResultInfo.BuffId);
            if(_loc3_ >= 0)
            {
               if(_loc4_.ResultInfo.HurtHp != 0)
               {
                  CurHealth -= _loc4_.ResultInfo.HurtHp;
                  if(this.FTextFunction != null)
                  {
                     if(_loc4_.ResultInfo.HurtHp < 0)
                     {
                        this.FTextFunction(TBattleStage.TYPETEXT_Float,Camp == 0 ? -1 : 1,this.x,this.y - this.RoleHeight,"+" + int(Math.abs(_loc4_.ResultInfo.HurtHp)),false,CONST_BATTLE.GetBuffSkillIndex(_loc4_.ResultInfo.BuffId));
                     }
                     else
                     {
                        this.FTextFunction(TBattleStage.TYPETEXT_Float,Camp == 0 ? -1 : 1,this.x,this.y - this.RoleHeight,int(_loc4_.ResultInfo.HurtHp),false,CONST_BATTLE.GetBuffSkillIndex(_loc4_.ResultInfo.BuffId));
                     }
                  }
                  this.CheckDie();
               }
               if(_loc4_.ResultInfo.HurtAnger != 0)
               {
                  CurAnger -= _loc4_.ResultInfo.HurtAnger;
               }
            }
            _loc2_++;
         }
      }
      
      public function CheckBuffs(param1:int = 0) : void
      {
         var _loc2_:* = 0;
         var _loc3_:Boolean = false;
         _loc2_ = 0;
         while(_loc2_ < this.FBuffTurnVect.length)
         {
            if(this.CheckBuffContinued(this.FBuffIdVect[_loc2_],param1))
            {
               _loc3_ = this.FIsNewBuffVect[_loc2_];
               if(_loc3_)
               {
                  this.FIsNewBuffVect[_loc2_] = false;
               }
               else
               {
                  --this.FBuffTurnVect[_loc2_];
                  if(this.FBuffTurnVect[_loc2_] <= 0)
                  {
                     this.DelBuffByIndex(_loc2_);
                     _loc2_--;
                  }
               }
            }
            _loc2_++;
         }
      }
      
      public function ChgNewBuffs() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Boolean = false;
         _loc1_ = 0;
         while(_loc1_ < this.FBuffTurnVect.length)
         {
            this.FIsNewBuffVect[_loc1_] = false;
            _loc1_++;
         }
      }
      
      public function CheckBuffUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Sprite = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:TBuffEffect = null;
         _loc1_ = 0;
         while(_loc1_ < this.FBuffIdVect.length)
         {
            _loc2_ = int(this.FBuffIdVect[_loc1_]);
            _loc3_ = this.FBuffSpriteVect[_loc1_];
            if(Camp == 0)
            {
               _loc4_ = CONST_BUFF_StampX_Left + int(_loc1_ / CONST_BUFF_Const) * CONST_BUFF_Width;
               _loc5_ = CONST_BUFF_StampY + int(_loc1_ % CONST_BUFF_Const) * CONST_BUFF_Height;
            }
            else
            {
               _loc4_ = CONST_BUFF_StampX_Right + int(_loc1_ / CONST_BUFF_Const) * CONST_BUFF_Width - CONST_BUFF_Width;
               _loc5_ = CONST_BUFF_StampY + int(_loc1_ % CONST_BUFF_Const) * CONST_BUFF_Height;
            }
            _loc6_ = this.FBuffBins.GetDatebaseByIdentifier(_loc2_) as TBuffEffect;
            _loc3_.x = _loc4_;
            _loc3_.y = _loc5_;
            TGameUtil.ShowImageByID(TGameUtil.Type_Buff,_loc3_.getChildAt(0) as Bitmap,FModelId,_loc6_.IconUrl);
            _loc1_++;
         }
      }
      
      public function CheckDie() : void
      {
         if(CurHealth <= 0.1)
         {
            FWaitDie = true;
         }
      }
      
      public function ChgPosition(param1:Vector.<TTargetInfo>) : void
      {
      }
      
      public function AddStatus(param1:TTargetInfo) : void
      {
         var _loc2_:int = 0;
         if(param1 != null)
         {
            if(param1.TargetStatus & CONST_BATTLE.ActiveType_Punch)
            {
               this.AddTextEffect(param1.TargetStatus);
            }
         }
      }
      
      public function DelStatus(param1:int, param2:int = -1) : Boolean
      {
         var _loc3_:TGoneWord = null;
         _loc3_ = this.FStatusGoneWordDict[param1];
         if(_loc3_ != null)
         {
            if(param2 >= 0)
            {
               this.FTextFunction(TBattleStage.TYPETEXT_Float,0,this.x,this.y - this.RoleHeight,"0",false,param2);
            }
            _loc3_.SaveSelf();
            this.FStatusGoneWordDict[param1] = null;
            return true;
         }
         return false;
      }
      
      public function FightMoveBack() : void
      {
         TweenUtil.to(this,200,{
            "x":FIdlePosition[0],
            "y":FIdlePosition[1]
         });
      }
      
      public function ResetRole(param1:TUIComponent, param2:TRoleBattleInfo, param3:uint, param4:TBattleStage, param5:Boolean = false, param6:Function = null, param7:int = 0) : void
      {
         ResetBaseRole(param1,param2,param3,param5);
         this.FBattleStage = param4;
         this.FTextFunction = param6;
         FShaderBmp.visible = true;
         FHpBar.visible = true;
         FBuffSprite.visible = true;
         alpha = 1;
         FBitmap.filters = [];
         this.filters = [];
         FSkillId = 0;
         FBitmap.visible = true;
         this.DelStatus(CONST_BATTLE.TEXT_FIGHT_STATUS_OtherTurn);
         this.InitCharacter();
      }
      
      override public function Releasing() : void
      {
         super.Releasing();
         this.FBattleStage = null;
      }
   }
}

